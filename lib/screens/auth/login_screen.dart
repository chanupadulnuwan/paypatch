import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 700;

            final headerH = isTablet ? 340.0 : 260.0;
            final overlap = isTablet ? 70.0 : 60.0;

            final panelColor = theme.brightness == Brightness.dark
                ? cs.primary.withOpacity(0.35)
                : cs.primary.withOpacity(0.92);

            final contentMaxW = isTablet ? 720.0 : double.infinity;

            return Column(
              children: [
                // TOP IMAGE
                SizedBox(
                  height: headerH,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/cover.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: cs.primary.withOpacity(0.25),
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported_outlined, size: 48),
                      );
                    },
                  ),
                ),

                // GREEN PANEL (fills the rest of the screen)
                Expanded(
                  child: Stack(
                    children: [
                      // panel background
                      Positioned(
                        top: -overlap,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: panelColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(34),
                              topRight: Radius.circular(34),
                            ),
                          ),
                        ),
                      ),

                      // panel content
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              22, // inside top padding
                              0,
                              24,
                            ),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: contentMaxW),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 40 : 18,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6),
                                      Text(
                                        'Welcome!',
                                        style: theme.textTheme.headlineMedium?.copyWith(
                                          color: cs.onPrimary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(height: 18),

                                      TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: cs.onSurface.withOpacity(0.7),
                                          ),
                                          hintText: 'Email',
                                          filled: true,
                                          fillColor: cs.surface,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      TextField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: cs.onSurface.withOpacity(0.7),
                                          ),
                                          hintText: 'Password',
                                          filled: true,
                                          fillColor: cs.surface,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 18),

                                      SizedBox(
                                        width: double.infinity,
                                        height: 52,
                                        child: FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: cs.secondary,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                                            );
                                          },
                                          child: const Text('Login'),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      Center(
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              "If you don't have an account ",
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                color: cs.onPrimary.withOpacity(0.9),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => const RegisterScreen(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'sign up',
                                                style: theme.textTheme.bodyMedium?.copyWith(
                                                  color: cs.secondary,
                                                  fontWeight: FontWeight.w800,
                                                  decoration: TextDecoration.underline,
                                                  decorationColor: cs.secondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
