// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import '../../models/group.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/profile_sheet.dart';
import '../../widgets/search_bar.dart';
import '../auth/login_screen.dart';
import 'group_detail_screen.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  Group? selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 700;

        if (isTablet) {
          return Row(
            children: [
              Expanded(child: _buildList(true)),
              Expanded(
                child: selected == null
                    ? const Center(child: Text('Select a group'))
                    : GroupDetailScreen(group: selected!),
              ),
            ],
          );
        }

        return _buildList(false);
      },
    );
  }

  void _openProfileSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ProfileSheet(
          onLogout: () {
            Navigator.pop(context); // close sheet
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        );
      },
    );
  }

  String _greetingText() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  
  Widget _buildList(bool isTablet) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    const userName = 'chanupa'; // dummy
    final greeting = _greetingText();

    return Scaffold(
      backgroundColor: cs.surface,

      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary, 
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create New Group (UI only)')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create New Group'),
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // GREEN HEADER WITH GREETING AND SEARCH
          Container(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello $userName!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            greeting,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _openProfileSheet,
                      icon:
                          const Icon(Icons.person_outline, color: Colors.white),
                      tooltip: 'Profile',
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Theme toggle (UI only)'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.dark_mode_outlined,
                          color: Colors.white),
                      tooltip: 'Theme',
                    ),
                  ],
                ),
                const SizedBox(height: 17), //hearder hight
                const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: SizedBox(
                    height: 40, // change this value
                    child: AppSearchBar(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ORANGE BALANCE CARD (full width)
          Card(
            elevation: 0,
            color: cs.secondary,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '\$450.50 ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'you are owed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // page padding with group list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Groups',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),

                // ===== GROUPS LIST =====
                ...sampleGroups.map((group) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    color: const Color.fromARGB(255, 245, 251, 245), // <- force white
                    surfaceTintColor:
                        Colors.transparent, // <- stop Material3 tint
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: cs.outlineVariant), // gray border
                    ),
                    child: ListTile(
                      leading: Hero(
                        tag: group.id,
                        child: CircleAvatar(
                          backgroundColor: cs.outlineVariant, // gray background
                          child: const Icon(Icons.groups,
                              color: Colors.white), // white icon
                        ),
                      ),
                      title: Text(
                        group.name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text('${group.members} members'),
                      trailing: Text(
                        group.balance >= 0
                            ? '+\$${group.balance.toStringAsFixed(2)}'
                            : '-\$${group.balance.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: group.balance >= 0
                              ? const Color.fromARGB(255, 10, 95, 13)
                              : const Color.fromARGB(255, 244, 120, 54),
                        ),
                      ),
                      onTap: () {
                        if (isTablet) {
                          setState(() => selected = group);
                        } else {
                          Navigator.push(
                            context,
                            AppRoutes.slide(GroupDetailScreen(group: group)),
                          );
                        }
                      },
                    ),
                  );
                }),

                // space for FAB
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
