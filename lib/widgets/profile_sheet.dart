import 'package:flutter/material.dart';

class ProfileSheet extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileSheet({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 14),

            const CircleAvatar(
              radius: 34,
              child: Icon(Icons.person, size: 34),
            ),
            const SizedBox(height: 10),

            Text('Chanupa Dulnuwan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text('chanupa@example.com', style: TextStyle(color: cs.onSurface.withOpacity(0.7))),
            const SizedBox(height: 2),
            Text('+94 77 123 4567', style: TextStyle(color: cs.onSurface.withOpacity(0.7))),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Premium upgrade (UI only)')),
                  );
                },
                icon: const Icon(Icons.workspace_premium_outlined),
                label: const Text('Upgrade to Premium'),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onLogout,
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
