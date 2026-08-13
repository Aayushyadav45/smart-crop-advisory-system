import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/api_service.dart'; // <-- import your API service

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});
  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  bool isLoading = false; // <-- add this variable

  // PUT THE FUNCTION HERE — as a method of this class
  Future<void> scanLeaf() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    setState(() => isLoading = true);

    try {
      final result = await ApiService.predictDisease(File(pickedFile.path));
      // use `result` (simple usage to avoid unused-local warning)
      print('Prediction result: $result');
      // TODO: navigate to Result screen, passing `result`
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Leaf")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: scanLeaf, // <-- your button calls the function
                child: const Text("Tap to Scan"),
              ),
      ),
    );
  }
}