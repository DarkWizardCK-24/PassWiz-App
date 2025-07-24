import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConditionIndicator extends StatelessWidget {
  final String condition;
  final bool isMet;
  final IconData icon;

  const ConditionIndicator({
    super.key,
    required this.condition,
    required this.isMet,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(isMet ? 0.4 : 0.2),
              Colors.white.withOpacity(isMet ? 0.2 : 0.1),
            ],
          ),
        ),
        child: Row(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isMet ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.circle,
                key: ValueKey<bool>(isMet),
                color: isMet ? Color(0xFF2ECC71) : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Icon(icon, color: isMet ? Colors.white : Colors.grey, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                condition,
                style: TextStyle(
                  color: isMet ? Colors.white : Colors.grey[200],
                  fontWeight: isMet ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}