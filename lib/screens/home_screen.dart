import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_wiz/models/password_entropy.dart';
import 'package:pass_wiz/widgets/condition_indicator.dart';
import 'package:pass_wiz/widgets/copy_button.dart';
import 'package:pass_wiz/widgets/password_input_field.dart';
import 'package:pass_wiz/widgets/strength_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  double _entropy = 0.0;
  Map<String, dynamic> _strengthInfo = {};
  Map<String, bool> _conditions = {
    'lowercase': false,
    'uppercase': false,
    'digit': false,
    'special': false,
  };
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _updateEntropy(String password) {
    setState(() {
      _entropy = PasswordEntropy.calculateEntropy(password);
      _strengthInfo = PasswordEntropy.getStrengthInfo(_entropy);
      _conditions = PasswordEntropy.checkConditions(password);
      _animationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.05,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Secure Your Password',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    PasswordInputField(
                      controller: _controller,
                      onChanged: _updateEntropy,
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: StrengthIndicator(
                        entropy: _entropy,
                        strengthInfo: _strengthInfo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Password Requirements',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          ConditionIndicator(
                            condition: 'Lowercase Letters',
                            isMet: _conditions['lowercase'] ?? false,
                            icon: FontAwesomeIcons.a,
                          ),
                          ConditionIndicator(
                            condition: 'Uppercase Letters',
                            isMet: _conditions['uppercase'] ?? false,
                            icon: FontAwesomeIcons.font,
                          ),
                          ConditionIndicator(
                            condition: 'Numbers',
                            isMet: _conditions['digit'] ?? false,
                            icon: Icons.numbers,
                          ),
                          ConditionIndicator(
                            condition: 'Special Characters',
                            isMet: _conditions['reediting: true'] ?? false,
                            icon: FontAwesomeIcons.star,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: CopyButton(password: _controller.text),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}