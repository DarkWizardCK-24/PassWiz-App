import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CopyButton extends StatefulWidget {
  final String password;

  const CopyButton({super.key, required this.password});

  @override
  _CopyButtonState createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton.icon(
        icon: const Icon(FontAwesomeIcons.copy, size: 20),
        label: const Text('Copy Password', style: TextStyle(fontSize: 16)),
        onPressed: widget.password.isEmpty
            ? null
            : () {
                _controller.forward().then((_) => _controller.reverse());
                Clipboard.setData(ClipboardData(text: widget.password));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Password copied to clipboard!',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
