import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'diagnosis_screen.dart';
import '../providers/app_provider.dart';
import '../services/api_service.dart';

class ScanLeafScreen extends StatefulWidget {
  const ScanLeafScreen({super.key});

  @override
  State<ScanLeafScreen> createState() => _ScanLeafScreenState();
}

class _ScanLeafScreenState extends State<ScanLeafScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;

      setState(() => _isLoading = true);

      final bytes = await image.readAsBytes();
      final result = await ApiService.predictDisease(image);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiagnosisScreen(
            imageBytes: bytes,
            result: result,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get prediction: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appProvider.t('scan_leaf')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.camera_alt, color: Colors.white54, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          appProvider.t('camera_preview'),
                          style: const TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Capture button
              GestureDetector(
                onTap: _isLoading ? null : () => _pickImage(ImageSource.camera),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isLoading
                          ? Colors.grey
                          : Theme.of(context).colorScheme.primary,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2),
                            ),
                            child: Icon(
                              Icons.camera,
                              color: Theme.of(context).colorScheme.primary,
                              size: 36,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: _isLoading ? null : () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: Text(
                  appProvider.t('choose_gallery'),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}