import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../config.dart';

class PredictionResult {
  final String disease;
  final double confidence;
  final String remedyEn;
  final String remedyLocal;

  PredictionResult({
    required this.disease,
    required this.confidence,
    required this.remedyEn,
    required this.remedyLocal,
  });

  factory PredictionResult.fromJson(Map<String, dynamic> json) {
    return PredictionResult(
      disease: json['disease'],
      confidence: json['confidence'].toDouble(),
      remedyEn: json['remedy_en'],
      remedyLocal: json['remedy_local'],
    );
  }
}

class ApiService {
  static Future<PredictionResult> predictDisease(XFile imageFile) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/predict");
    final request = http.MultipartRequest('POST', uri);

    final bytes = await imageFile.readAsBytes();

    // XFile.mimeType is often accurate (e.g. "image/jpeg"); fall back to
    // guessing from the filename, then to a safe default.
    final mimeType = imageFile.mimeType ?? _guessMimeType(imageFile.name);

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: imageFile.name,
        contentType: MediaType.parse(mimeType),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return PredictionResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        "Prediction failed: ${response.statusCode} ${response.body}",
      );
    }
  }

  static String _guessMimeType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    // Covers .jpg and .jpeg, and is a reasonable default otherwise.
    return 'image/jpeg';
  }
}