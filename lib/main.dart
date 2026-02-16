import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const PayPatchApp());
}

class PayPatchApp extends StatefulWidget {
  const PayPatchApp({super.key});

  static _PayPatchAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_PayPatchAppState>()!;

  @override
  State<PayPatchApp> createState() => _PayPatchAppState();
}

class _PayPatchAppState extends State<PayPatchApp> {
  final ThemeController controller = ThemeController();

  @override
  void initState() {
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PayPatch',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: controller.themeMode,
      home: const HomeScreen(),
    );
  }
}
