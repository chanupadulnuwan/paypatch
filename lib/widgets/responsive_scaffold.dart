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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800; // tablet/desktop

        if (!isWide) {
          // Mobile layout: bottom navigation
          return Scaffold(
            body: pages[index],
            bottomNavigationBar: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: onIndexChanged,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.groups_outlined),
                  selectedIcon: Icon(Icons.groups),
                  label: 'Groups',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_add_alt_1_outlined),
                  selectedIcon: Icon(Icons.person_add_alt_1),
                  label: 'Friends',
                ),
                NavigationDestination(
                  icon: Icon(Icons.timeline_outlined),
                  selectedIcon: Icon(Icons.timeline),
                  label: 'Activity',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        }

        // Tablet layout: NavigationRail + content (different layout = marks)
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: index,
                onDestinationSelected: onIndexChanged,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.groups_outlined),
                    selectedIcon: Icon(Icons.groups),
                    label: Text('Groups'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_add_alt_1_outlined),
                    selectedIcon: Icon(Icons.person_add_alt_1),
                    label: Text('Friends'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.timeline_outlined),
                    selectedIcon: Icon(Icons.timeline),
                    label: Text('Activity'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
              ),
              const VerticalDivider(width: 1),
              Expanded(child: pages[index]),
            ],
          ),
        );
      },
    );
  }
}
