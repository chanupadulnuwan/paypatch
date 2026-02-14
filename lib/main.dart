import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

void main() => runApp(const PayPatchApp());

class PayPatchApp extends StatelessWidget {
  const PayPatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayPatch',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
