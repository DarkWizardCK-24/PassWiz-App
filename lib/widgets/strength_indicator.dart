import 'package:flutter/material.dart';
import 'package:pass_wiz/theme/app_theme.dart';

class StrengthIndicator extends StatelessWidget {
  final double entropy;
  final Map<String, dynamic> strengthInfo;

  const StrengthIndicator({
    super.key,
    required this.entropy,
    required this.strengthInfo,
  });

  @override
  Widget build(BuildContext context) {
    double progress = entropy / 100; // Normalize entropy to 0-1 for progress bar
    if (progress > 1) progress = 1;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entropy: ${entropy.toStringAsFixed(2)} bits',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(strengthInfo['color'] ?? Colors.grey),
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),
            Text(
              'Strength: ${strengthInfo['strength'] ?? 'N/A'}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: strengthInfo['color'] ?? Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crack Time: ${strengthInfo['crackTime'] ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}