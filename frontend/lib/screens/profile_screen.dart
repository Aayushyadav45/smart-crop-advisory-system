import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/app_provider.dart';
import '../theme/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  void _showEditNameDialog(BuildContext context, AppProvider appProvider) {
    final TextEditingController nameController = TextEditingController(text: appProvider.farmerName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(appProvider.language == 'hi' ? 'नाम संपादित करें' : 'Edit Name', style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: appProvider.language == 'hi' ? 'अपना नाम दर्ज करें' : 'Enter your name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2), borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appProvider.language == 'hi' ? 'रद्द करें' : 'Cancel', style: const TextStyle(color: AppColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                if (nameController.text.trim().isNotEmpty) {
                  appProvider.setFarmerName(nameController.text.trim());
                }
                Navigator.pop(context);
              },
              child: Text(appProvider.language == 'hi' ? 'सहेजें' : 'Save', style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickProfileImage(AppProvider appProvider) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        appProvider.setProfileImagePath(image.path);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
    }
  }

  void _showHelpContactDialog(BuildContext context, AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.support_agent, color: AppColors.primaryGreen, size: 28),
              const SizedBox(width: 8),
              Text(appProvider.language == 'hi' ? 'संपर्क करें' : 'Contact Us', style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appProvider.language == 'hi' ? 'सहायता के लिए हमारे टोल-फ्री नंबर पर कॉल करें:' : 'Call our toll-free number for support:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryGreen),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: AppColors.primaryGreen),
                    SizedBox(width: 8),
                    Text(
                      '1800-123-4567',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(appProvider.language == 'hi' ? 'बंद करें' : 'Close', style: const TextStyle(color: AppColors.primaryGreen)),
            ),
          ],
        );
      },
    );
  }

  void _showFarmDetailsBottomSheet(BuildContext context, AppProvider appProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              Text(
                appProvider.language == 'hi' ? 'खेत का विवरण' : 'Farm Details',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
              ),
              const SizedBox(height: 20),
              _buildFarmDetailItem(Icons.square_foot, appProvider.language == 'hi' ? 'खेत का आकार' : 'Farm Size', '5 Acres'),
              const Divider(height: 24),
              _buildFarmDetailItem(Icons.grass, appProvider.language == 'hi' ? 'मुख्य फसलें' : 'Primary Crops', 'Wheat, Mustard, Tomato'),
              const Divider(height: 24),
              _buildFarmDetailItem(Icons.water_drop, appProvider.language == 'hi' ? 'सिंचाई का प्रकार' : 'Irrigation Type', 'Drip Irrigation'),
              const Divider(height: 24),
              _buildFarmDetailItem(Icons.terrain, appProvider.language == 'hi' ? 'मिट्टी का प्रकार' : 'Soil Type', 'Loamy Soil'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFarmDetailItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryGreen, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 16, color: AppColors.textMuted)),
        ),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appProvider.t('profile')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () => _pickProfileImage(appProvider),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryGreenLight,
                        border: Border.all(color: AppColors.primaryGreen, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: appProvider.profileImagePath != null
                            ? DecorationImage(
                                image: FileImage(File(appProvider.profileImagePath!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: appProvider.profileImagePath == null
                          ? const Icon(Icons.person, size: 60, color: AppColors.primaryGreen)
                          : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pickProfileImage(appProvider),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appProvider.farmerName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primaryGreen, size: 20),
                  onPressed: () => _showEditNameDialog(context, appProvider),
                )
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'User ID: #987654',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
            const SizedBox(height: 40),

            // Profile Options
            _buildProfileCard(
              icon: Icons.grass,
              title: appProvider.t('farm_details'),
              onTap: () => _showFarmDetailsBottomSheet(context, appProvider),
            ),
            const SizedBox(height: 16),
            
            // Language Switcher
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.schemeAmberLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.language, color: AppColors.schemeAmber),
                ),
                title: Text(
                  appProvider.t('lang'),
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                trailing: DropdownButton<String>(
                  value: appProvider.language,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'hi', child: Text('हिंदी (Hindi)')),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      appProvider.setLanguage(newValue);
                    }
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            _buildProfileCard(
              icon: Icons.notifications_active_outlined,
              title: appProvider.t('notification_settings'),
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              icon: Icons.help_outline,
              title: appProvider.t('help_support'),
              subtitle: '1800-123-4567',
              onTap: () => _showHelpContactDialog(context, appProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard({required IconData icon, required String title, String? subtitle, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryGreenLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.textDark),
        ),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textMuted),
      ),
    );
  }
}
