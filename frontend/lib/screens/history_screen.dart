import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(appProvider.t('history')),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildScanItem(
            context,
            appProvider.t('tomato_blight'),
            appProvider.language == 'hi' ? '2 दिन पहले' : '2 days ago',
            true,
          ),
          const SizedBox(height: 16),
          _buildScanItem(
            context,
            appProvider.language == 'hi' ? 'आलू - स्वस्थ' : 'Potato - Healthy',
            appProvider.language == 'hi' ? '5 दिन पहले' : '5 days ago',
            false,
          ),
          const SizedBox(height: 16),
          _buildScanItem(
            context,
            appProvider.language == 'hi' ? 'टमाटर - लीफ मोल्ड' : 'Tomato - Leaf Mold',
            appProvider.language == 'hi' ? '1 सप्ताह पहले' : '1 week ago',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildScanItem(BuildContext context, String title, String time, bool isIssue) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/diagnosis');
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isIssue ? AppColors.alertRed.withValues(alpha: 0.1) : AppColors.primaryGreen.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isIssue ? AppColors.alertRedLight : AppColors.primaryGreenLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isIssue ? Icons.bug_report : Icons.eco,
                color: isIssue ? AppColors.alertRed : AppColors.primaryGreen,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

