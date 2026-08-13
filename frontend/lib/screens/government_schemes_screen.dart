import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/colors.dart';

class GovernmentSchemesScreen extends StatelessWidget {
  const GovernmentSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final bool isHi = appProvider.language == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(appProvider.t('schemes'), style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.schemeAmber, Color(0xFFF57F17)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.schemeAmber.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHi ? 'सरकारी योजनाएं' : 'Government Schemes',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isHi ? 'किसानों के लिए वित्तीय सहायता और सब्सिडी प्राप्त करें' : 'Get financial support and subsidies for farmers',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSchemeCard(
                  title: 'PM-KISAN',
                  subtitle: isHi ? '₹6000 प्रति वर्ष आय सहायता' : '₹6000 per year income support',
                  icon: Icons.currency_rupee,
                ),
                const SizedBox(height: 16),
                _buildSchemeCard(
                  title: isHi ? 'मृदा स्वास्थ्य कार्ड' : 'Soil Health Card',
                  subtitle: isHi ? 'फसल-वार उर्वरक सिफारिशें' : 'Crop-wise nutrient recommendations',
                  icon: Icons.landscape,
                ),
                const SizedBox(height: 16),
                _buildSchemeCard(
                  title: isHi ? 'फसल बीमा योजना' : 'Pradhan Mantri Fasal Bima Yojana',
                  subtitle: isHi ? 'प्राकृतिक आपदाओं के खिलाफ फसल सुरक्षा' : 'Crop insurance against natural calamities',
                  icon: Icons.security,
                ),
                const SizedBox(height: 16),
                _buildSchemeCard(
                  title: isHi ? 'कृषि सिंचाई योजना' : 'Krishi Sinchayee Yojana',
                  subtitle: isHi ? 'पानी के उपयोग की दक्षता में सुधार' : 'Improve on-farm water use efficiency',
                  icon: Icons.water_drop,
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemeCard({required String title, required String subtitle, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.schemeAmberLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.schemeAmberLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: AppColors.schemeAmber, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_ios, color: AppColors.schemeAmber, size: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
