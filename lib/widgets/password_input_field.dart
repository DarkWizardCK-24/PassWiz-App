import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: TextField(
          style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white70),
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Enter Password',
            prefixIcon: const Icon(FontAwesomeIcons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                size: 20,
              ),
              onPressed: _toggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}