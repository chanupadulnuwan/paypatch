import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexChanged;
  final List<Widget> pages;

  const ResponsiveScaffold({
    super.key,
    required this.index,
    required this.onIndexChanged,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: pages[index],

      // ALWAYS bottom navigation (no left rail)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? cs.surface : cs.surface,
          border: Border(
            top: BorderSide(
              color: cs.outlineVariant,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: onIndexChanged,
          type: BottomNavigationBarType.fixed, // spread across full width
          showUnselectedLabels: true,
          backgroundColor: isDark ? cs.surface : cs.surface,
          selectedItemColor: cs.primary,
          unselectedItemColor: cs.onSurface.withOpacity(isDark ? 0.65 : 0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add_alt_1_outlined),
              activeIcon: Icon(Icons.person_add_alt_1),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline_outlined),
              activeIcon: Icon(Icons.timeline),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
