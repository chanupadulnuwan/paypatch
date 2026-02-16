import 'package:flutter/material.dart';

import '../../main.dart';
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
            Navigator.pop(context);
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const userName = 'chanupa';
    final greeting = _greetingText();

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final headerBg = isDark ? cs.surface : cs.primary;
    final headerText = isDark ? cs.onSurface : Colors.white;
    final headerSubText =
        isDark ? cs.onSurface.withOpacity(0.7) : Colors.white70;

    final groupCardBg = isDark ? cs.surfaceVariant : lightPageBg;

    return Scaffold(
      backgroundColor: cs.surface,

      // ✅ FAB updated for dark mode
      floatingActionButton: isDark
          ? FloatingActionButton.extended(
              backgroundColor: cs.surface,
              foregroundColor: cs.primary, // green text/icon
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: cs.primary, width: 1.2), // green border
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create New Group (UI only)')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Create New Group'),
            )
          : FloatingActionButton.extended(
              backgroundColor: cs.primary,
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
          // ===== HEADER =====
          Container(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
            decoration: BoxDecoration(
              color: headerBg,
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
                            style: TextStyle(
                              color: headerText,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            greeting,
                            style: TextStyle(color: headerSubText),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _openProfileSheet,
                      icon: Icon(Icons.person_outline, color: headerText),
                      tooltip: 'Profile',
                    ),
                    IconButton(
                      onPressed: () {
                        PayPatchApp.of(context).controller.toggleTheme();
                      },
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: headerText,
                      ),
                      tooltip: 'Theme',
                    ),
                  ],
                ),
                const SizedBox(height: 17),

                // ✅ Search bar visibility fix in dark mode
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? cs.surfaceVariant.withOpacity(0.9) // dark gray
                        : Colors.transparent, // keep original light look
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: const AppSearchBar(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ===== BALANCE CARD =====
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: isDark ? cs.surface : cs.secondary,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isDark ? cs.secondary : Colors.transparent,
                width: isDark ? 1.2 : 0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: isDark ? cs.secondary : Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$450.50 ',
                            style: TextStyle(
                              color: isDark ? cs.onSurface : Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'you are owed',
                            style: TextStyle(
                              color: isDark ? cs.secondary : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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

          // ===== GROUP LIST AREA =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Groups',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: isDark ? cs.onSurface : null,
                  ),
                ),
                const SizedBox(height: 12),

                ...sampleGroups.map((group) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    color: groupCardBg,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: cs.outlineVariant),
                    ),
                    child: ListTile(
                      leading: Hero(
                        tag: group.id,
                        child: CircleAvatar(
                          backgroundColor: isDark
                              ? cs.primary.withOpacity(0.25)
                              : cs.outlineVariant,
                          child: Icon(
                            Icons.groups,
                            color: isDark ? cs.primary : Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        group.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: isDark ? cs.onSurface : null,
                        ),
                      ),
                      subtitle: Text(
                        '${group.members} members',
                        style: TextStyle(
                          color: isDark ? cs.onSurface.withOpacity(0.7) : null,
                        ),
                      ),
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

                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
