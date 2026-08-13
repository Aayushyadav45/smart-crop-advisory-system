// lib/services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
  static Future<PredictionResult> predictDisease(File imageFile) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/predict");
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return PredictionResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Prediction failed: ${response.statusCode} ${response.body}");
    }
  }
}