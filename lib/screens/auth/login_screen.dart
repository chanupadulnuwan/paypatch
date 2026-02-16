import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final panelColor = theme.brightness == Brightness.dark
        ? cs.primary.withOpacity(0.35)
        : cs.primary.withOpacity(0.92);

    return Scaffold(
      // makes any extra unused space green (fixes top/bottom white space later i ll add doddle for there)
      backgroundColor: panelColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 900;

            Widget buildTopImage({BoxFit fit = BoxFit.cover}) {
              return Image.asset(
                'assets/images/cover.jpg',
                fit: fit,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: cs.primary.withOpacity(0.25),
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported_outlined, size: 48),
                  );
                },
              );
            }

            Widget buildForm({required bool isWide}) {
              final contentMaxW = isWide ? 520.0 : double.infinity;

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxW),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 40 : 18,
                      vertical: isWide ? 40 : 0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
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
              );
            }

            // DESKTOP: Left panel + Right image, no overlap, no rounded
            if (isDesktop) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      color: panelColor,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: buildForm(isWide: true),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: panelColor, // if image doesn't fill, still green
                      child: buildTopImage(fit: BoxFit.cover),
                    ),
                  ),
                ],
              );
            }

            // MOBILE: keep overlap + rounded
            const headerH = 260.0;
            const overlap = 60.0;

            return Column(
              children: [
                SizedBox(
                  height: headerH,
                  width: double.infinity,
                  child: buildTopImage(),
                ),
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -overlap),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: panelColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0, 22, 0, 24),
                        child: buildForm(isWide: false),
                      ),
                    ),
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
