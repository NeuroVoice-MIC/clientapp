import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class VoiceMlApi {
  static const String _baseUrl = 'https://neurovoice-level1-ml.onrender.com';
  static const String _endpoint = '/predict';

  static Future<Map<String, dynamic>> uploadWav({
    required String wavPath,
  }) async {
    final uri = Uri.parse('$_baseUrl$_endpoint');

    debugPrint('➡️ Sending request to: $uri');
    debugPrint('🎧 Audio path: $wavPath');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio',
        wavPath,
        contentType: MediaType('audio', 'wav'),
      ),
    );

    try {
      final streamedResponse = await request.send().timeout(
        const Duration(minutes: 3),
      );

      debugPrint('⬅️ HTTP status: ${streamedResponse.statusCode}');

      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('📦 Raw response body: ${response.body}');

      final decoded = jsonDecode(response.body);

      debugPrint('✅ Decoded JSON: $decoded');

      if (response.statusCode != 200) {
        throw Exception(
          decoded is Map && decoded['message'] != null
              ? decoded['message']
              : 'Prediction failed',
        );
      }

      if (decoded is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      return decoded;
    } on SocketException {
      debugPrint('❌ SocketException: No internet connection');
      throw Exception('No internet connection');
    } on FormatException catch (e) {
      debugPrint('❌ JSON FormatException: $e');
      throw Exception('Invalid JSON from server');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      rethrow;
    }
  }
}
