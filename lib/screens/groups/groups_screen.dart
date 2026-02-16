import 'package:flutter/material.dart';

import '../../main.dart';
import '../../data/sample_data.dart';
import '../../models/group.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/profile_sheet.dart';
import '../../widgets/search_bar.dart';
import '../auth/login_screen.dart';
import 'group_detail_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  void _openProfileSheet(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    const userName = 'chanupa';
    final greeting = _greetingText();

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final headerBg = isDark ? cs.surface : cs.primary;
    final headerText = isDark ? cs.onSurface : Colors.white;
    final headerSubText =
        isDark ? cs.onSurface.withOpacity(0.7) : Colors.white70;

    final groupCardBg = isDark ? cs.surfaceVariant : lightPageBg;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 700;

        return Scaffold(
          backgroundColor: cs.surface,

          floatingActionButton: isDark
              ? FloatingActionButton.extended(
                  backgroundColor: cs.surface,
                  foregroundColor: cs.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: cs.primary, width: 1.2),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Create New Group (UI only)')),
                    );
                  },
                  icon: Icon(Icons.add, size: isTablet ? 26 : 24),
                  label: Text(
                    'Create New Group',
                    style: TextStyle(fontSize: isTablet ? 16 : 14),
                  ),
                )
              : FloatingActionButton.extended(
                  backgroundColor: cs.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Create New Group (UI only)')),
                    );
                  },
                  icon: Icon(Icons.add, size: isTablet ? 26 : 24),
                  label: Text(
                    'Create New Group',
                    style: TextStyle(fontSize: isTablet ? 16 : 14),
                  ),
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
                                  fontSize: isTablet ? 26 : 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                greeting,
                                style: TextStyle(
                                  color: headerSubText,
                                  fontSize: isTablet ? 16 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => _openProfileSheet(context),
                          icon: Icon(Icons.person_outline,
                              color: headerText, size: isTablet ? 26 : 24),
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
                            size: isTablet ? 26 : 24,
                          ),
                          tooltip: 'Theme',
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),

                    // Search bar visibility fix in dark mode
                    Container(
                      height: isTablet ? 46 : 40,
                      decoration: BoxDecoration(
                        color: isDark
                            ? cs.surfaceVariant.withOpacity(0.9)
                            : Colors.transparent,
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
                  padding: EdgeInsets.all(isTablet ? 20 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          color: isDark ? cs.secondary : Colors.white70,
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 16 : 14,
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
                                  fontSize: isTablet ? 34 : 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: 'you are owed',
                                style: TextStyle(
                                  color: isDark ? cs.secondary : Colors.white,
                                  fontSize: isTablet ? 18 : 16,
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

              // TITLE 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Your Groups',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: isTablet ? 28 : null,
                    color: isDark ? cs.onSurface : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              //  MOBILE: SAME LIST VIEW / TABLET: BIG BOX GRID 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: isTablet
                    ? _TabletGrid(
                        groups: sampleGroups,
                        cardBg: groupCardBg,
                      )
                    : _MobileList(
                        groups: sampleGroups,
                        cardBg: groupCardBg,
                      ),
              ),

              const SizedBox(height: 90),
            ],
          ),
        );
      },
    );
  }
}

// ------ MOBILE LIST 
class _MobileList extends StatelessWidget {
  final List<Group> groups;
  final Color cardBg;

  const _MobileList({required this.groups, required this.cardBg});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: groups.map((group) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          color: cardBg,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: cs.outlineVariant),
          ),
          child: ListTile(
            leading: Hero(
              tag: group.id,
              child: CircleAvatar(
                backgroundColor:
                    isDark ? cs.primary.withOpacity(0.25) : cs.outlineVariant,
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
              Navigator.push(
                context,
                AppRoutes.slide(GroupDetailScreen(group: group)),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

// ---- TABLET GRID (big box cards + bigger fonts/icons) 
class _TabletGrid extends StatelessWidget {
  final List<Group> groups;
  final Color cardBg;

  const _TabletGrid({required this.groups, required this.cardBg});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groups.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 3.0,
      ),
      itemBuilder: (context, i) {
        final group = groups[i];

        return Card(
          elevation: 0,
          color: cardBg,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: cs.outlineVariant),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                AppRoutes.slide(GroupDetailScreen(group: group)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Hero(
                    tag: group.id,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: isDark
                          ? cs.primary.withOpacity(0.25)
                          : cs.outlineVariant,
                      child: Icon(
                        Icons.groups,
                        size: 28,
                        color: isDark ? cs.primary : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: isDark ? cs.onSurface : null,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${group.members} members',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? cs.onSurface.withOpacity(0.7) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    group.balance >= 0
                        ? '+\$${group.balance.toStringAsFixed(2)}'
                        : '-\$${group.balance.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: group.balance >= 0
                          ? const Color.fromARGB(255, 10, 95, 13)
                          : const Color.fromARGB(255, 244, 120, 54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
