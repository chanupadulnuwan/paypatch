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

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Top image banner
                  _HeaderImage(isTablet: isTablet),

                  // Form card area
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 48 : 16,
                      vertical: isTablet ? 24 : 16,
                    ),
                    child: Container(
                      width: isTablet ? 700 : double.infinity,
                      padding: EdgeInsets.all(isTablet ? 28 : 18),
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(theme.brightness == Brightness.dark ? 0.35 : 0.90),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome!',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 18),

                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
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
                              prefixIcon: const Icon(Icons.lock_outline),
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
                              // No real auth required. This just lets you demo navigation.
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                                );
                              },
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 14),

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
                                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                                    );
                                  },
                                  child: Text(
                                    'sign up',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: cs.secondary,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: cs.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage({required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isTablet ? 260 : 220,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isTablet ? 40 : 28),
          bottomRight: Radius.circular(isTablet ? 40 : 28),
        ),
        child: Image.asset(
          'assets/images/wallet.jpg', // put your image here
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // fallback if image missing (still looks fine)
            return Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported_outlined, size: 48),
            );
          },
        ),
      ),
    );
  }
}
