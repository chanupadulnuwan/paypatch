import 'package:flutter/material.dart';

import '../../widgets/responsive_scaffold.dart';
import '../groups/groups_screen.dart';
import '../friends/friends_screen.dart';
import '../activity/activity_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _pages = const [
    GroupsScreen(),
    FriendsScreen(),
    ActivityScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      index: _index,
      onIndexChanged: (i) => setState(() => _index = i),
      pages: _pages,
    );
  }
}
