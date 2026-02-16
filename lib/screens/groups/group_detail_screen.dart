import 'package:flutter/material.dart';
import '../../models/group.dart';

class GroupDetailScreen extends StatelessWidget {
  final Group group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final pageBg = isDark ? cs.surface : lightPageBg;
    final headerBg = isDark ? cs.surface : cs.primary;

    final headerTitleColor = isDark ? cs.onSurface : Colors.white;
    final headerSubColor =
        isDark ? cs.onSurface.withOpacity(0.7) : Colors.white70;

    final summaryText = group.balance >= 0
        ? 'You are owed \$${group.balance.toStringAsFixed(2)} overall'
        : 'You owe \$${group.balance.abs().toStringAsFixed(2)} overall';

    final summaryColor = group.balance >= 0
        ? const Color.fromARGB(255, 10, 95, 13)
        : const Color.fromARGB(255, 244, 120, 54);

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: headerBg,
        foregroundColor: headerTitleColor,
        elevation: 0,
        title: const SizedBox.shrink(),
        actions: [
          IconButton(
            tooltip: 'Add members (UI only)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add members (UI only)')),
              );
            },
            icon: Icon(Icons.person_add_alt_1, color: headerTitleColor),
          ),
          IconButton(
            tooltip: 'Edit group (UI only)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit group (UI only)')),
              );
            },
            icon: Icon(Icons.edit_outlined, color: headerTitleColor),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          //  HEADER
          Container(
            color: headerBg,
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: headerTitleColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Created: 2026-02-16',
                      style: TextStyle(color: headerSubColor),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${group.members} members',
                      style: TextStyle(color: headerSubColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // SUMMARY CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              color: isDark ? cs.surface : lightPageBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isDark ? cs.secondary : cs.outlineVariant,
                  width: isDark ? 1.2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    summaryText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark ? cs.secondary : summaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 3 ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _ActionPill(
                    label: 'Settle up',
                    isDark: isDark,
                    cs: cs,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settle up (UI only)')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionPill(
                    label: 'Balances',
                    isDark: isDark,
                    cs: cs,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Balances (UI only)')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionPill(
                    label: 'Totals',
                    isDark: isDark,
                    cs: cs,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Totals (UI only)')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // EXPENSE LIST TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Expenses',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? cs.onSurface : null,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // EXPENSE LIST
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                _ExpenseTile(
                  date: 'Feb 16',
                  icon: Icons.restaurant,
                  title: 'Lunch at Cafe Kandy',
                  subtitle: 'Paid by Kasun',
                  trailing: 'You owe \$8.50',
                ),
                SizedBox(height: 10),
                _ExpenseTile(
                  date: 'Feb 14',
                  icon: Icons.local_gas_station,
                  title: 'Fuel',
                  subtitle: 'Paid by Nimal',
                  trailing: 'You owe \$12.00',
                ),
                SizedBox(height: 10),
                _ExpenseTile(
                  date: 'Feb 12',
                  icon: Icons.shopping_cart_outlined,
                  title: 'Groceries',
                  subtitle: 'Paid by Kavindi',
                  trailing: 'You get \$5.00',
                ),
                SizedBox(height: 10),
                _ExpenseTile(
                  date: 'Feb 10',
                  icon: Icons.home_outlined,
                  title: 'Electricity bill',
                  subtitle: 'Paid by you',
                  trailing: 'You get \$15.00',
                ),
              ],
            ),
          ),

          const SizedBox(height: 90),
        ],
      ),

      // ADD EXPENSE BUTTON
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
                  const SnackBar(content: Text('Add expense (UI only)')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            )
          : FloatingActionButton.extended(
              backgroundColor: cs.primary,
              foregroundColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add expense (UI only)')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final bool isDark;
  final ColorScheme cs;
  final VoidCallback onTap;

  const _ActionPill({
    required this.label,
    required this.isDark,
    required this.cs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!isDark) {
      // light mode: orange filled like before
      return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: cs.secondary,
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(label),
      );
    }

    // dark mode: dark bg + orange border/text
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.secondary,
        side: BorderSide(color: cs.secondary, width: 1.2),
        backgroundColor: cs.surface,
      ),
      onPressed: onTap,
      child: Text(label),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  final String date;
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;

  const _ExpenseTile({
    required this.date,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final tileBg = isDark ? cs.surfaceVariant : lightPageBg;

    final trailingColor = trailing.contains('owe')
        ? const Color.fromARGB(255, 244, 120, 54)
        : const Color.fromARGB(255, 10, 95, 13);

    return Card(
      elevation: 0,
      color: tileBg,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              isDark ? cs.primary.withOpacity(0.25) : cs.outlineVariant,
          child: Icon(
            icon,
            color: isDark ? cs.primary : Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isDark ? cs.onSurface : null,
          ),
        ),
        subtitle: Text(
          '$date • $subtitle',
          style: TextStyle(
            color: isDark ? cs.onSurface.withOpacity(0.7) : null,
          ),
        ),
        trailing: Text(
          trailing,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isDark ? (trailing.contains('owe') ? cs.secondary : cs.primary) : trailingColor,
          ),
        ),
      ),
    );
  }
}
