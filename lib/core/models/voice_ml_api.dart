import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class VoiceMlApi {
  static const String _baseUrl = 'https://neurovoice-node.onrender.com/api';

  static Future<Map<String, dynamic>> uploadWav({
    required String wavPath,
  }) async {
    final uri = Uri.parse('$_baseUrl/voice-check');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio', // MUST match multer.single("audio")
        wavPath,
        contentType: MediaType('audio', 'wav'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Prediction failed: ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}