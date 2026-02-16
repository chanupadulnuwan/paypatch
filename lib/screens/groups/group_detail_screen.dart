import 'package:flutter/material.dart';
import '../../models/group.dart';

class GroupDetailScreen extends StatelessWidget {
  final Group group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    const pageBg = Color.fromARGB(255, 245, 251, 245); // same as your screens

    final summaryText = group.balance >= 0
        ? 'You are owed \$${group.balance.toStringAsFixed(2)} overall'
        : 'You owe \$${group.balance.abs().toStringAsFixed(2)} overall';

    final summaryColor = group.balance >= 0
        ? const Color.fromARGB(255, 10, 95, 13)
        : const Color.fromARGB(255, 244, 120, 54);

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: cs.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        // no title "Group"
        title: const SizedBox.shrink(),
        actions: [
          IconButton(
            tooltip: 'Add members (UI only)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add members (UI only)')),
              );
            },
            icon: const Icon(Icons.person_add_alt_1),
          ),
          IconButton(
            tooltip: 'Edit group (UI only)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit group (UI only)')),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ===== HEADER (THEMED, NOT ROUNDED) =====
          Container(
            color: cs.primary,
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Created: 2026-02-16',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${group.members} members',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ===== SUMMARY LINE =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              color: pageBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: cs.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    summaryText,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: summaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ===== 3 ACTION BUTTONS (ORANGE BACKGROUND) =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settle up (UI only)')),
                      );
                    },
                    child: const Text('Settle up'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Balances (UI only)')),
                      );
                    },
                    child: const Text('Balances'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.secondary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Totals (UI only)')),
                      );
                    },
                    child: const Text('Totals'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ===== EXPENSE LIST TITLE =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Expenses',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 10),

          // ===== EXPENSE LIST (STATIC DEMO DATA) =====
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

      // ===== ADD EXPENSE BUTTON =====
      floatingActionButton: FloatingActionButton.extended(
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
    const pageBg = Color.fromARGB(255, 245, 251, 245);

    return Card(
      elevation: 0,
      color: pageBg, // match page background
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.outlineVariant,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('$date • $subtitle'),
        trailing: Text(
          trailing,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: trailing.contains('owe')
                ? const Color.fromARGB(255, 244, 120, 54)
                : const Color.fromARGB(255, 10, 95, 13),
          ),
        ),
      ),
    );
  }
}
