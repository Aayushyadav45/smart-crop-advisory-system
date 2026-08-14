import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/app_provider.dart';
import '../theme/colors.dart';
import 'diagnosis_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final ImagePicker _picker = ImagePicker();
  bool _isLaunchingCamera = false;

  @override
  void initState() {
    super.initState();
    // Create a gentle swaying animation for the leaf logo
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      setState(() => _isLaunchingCamera = true);

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
      if (mounted) setState(() => _isLaunchingCamera = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            RotationTransition(
              turns: _animation,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.energy_savings_leaf, color: Colors.white, size: 28),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                appProvider.language == 'hi'
                    ? 'नमस्ते, ${appProvider.farmerName}'
                    : 'Namaste, ${appProvider.farmerName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textDark,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FAFB), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tap to scan a leaf
                GestureDetector(
                  onTap: _isLaunchingCamera ? null : _launchCamera,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -20,
                          bottom: -20,
                          child: Icon(
                            Icons.eco,
                            size: 140,
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        Center(
                          child: _isLaunchingCamera
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 36),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      appProvider.t('tap_to_scan'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Row for Weather and Schemes
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/advisory');
                        },
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.weatherBlueLight),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.weatherBlue.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.cloud, color: AppColors.weatherBlue, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    appProvider.t('weather'), 
                                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.weatherBlue)
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                appProvider.t('weather_desc'), 
                                style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/schemes');
                        },
                        child: Container(
                          height: 110,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.schemeAmberLight),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.schemeAmber.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.article, color: AppColors.schemeAmber, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    appProvider.t('schemes'), 
                                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.schemeAmber)
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                appProvider.t('schemes_desc'), 
                                style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                Text(
                  appProvider.t('recent_scans'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark),
                ),
                const SizedBox(height: 16),
                
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Scan history coming soon')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.alertRedLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.bug_report, color: AppColors.alertRed, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appProvider.t('tomato_blight'),
                                style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '1 day ago',
                                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}