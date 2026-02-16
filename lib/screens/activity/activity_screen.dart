import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final pageBg = isDark ? cs.surface : lightPageBg;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: isDark ? cs.surface : null,
        foregroundColor: isDark ? cs.onSurface : null,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _activityCard(
            context,
            title: 'Trip to Bali',
            subtitle: 'You paid \$200.50 • Split with 6 members',
            icon: Icons.flight_takeoff,
          ),
          const SizedBox(height: 10),
          _activityCard(
            context,
            title: 'Office Lunch',
            subtitle: 'You owe \$50.00 • Added by Kasun',
            icon: Icons.restaurant,
          ),
          const SizedBox(height: 10),
          _activityCard(
            context,
            title: 'Roommates',
            subtitle: 'Settlement reminder • Due this week',
            icon: Icons.home,
          ),
          const SizedBox(height: 10),
          _activityCard(
            context,
            title: 'Weekend Getaway',
            subtitle: 'New expense added • Taxi fare',
            icon: Icons.directions_car,
          ),
        ],
      ),
    );
  }

  Widget _activityCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const lightPageBg = Color.fromARGB(255, 245, 251, 245);

    final cardBg = isDark ? cs.surfaceVariant : lightPageBg;

    return Card(
      elevation: 0,
      color: cardBg,
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
          subtitle,
          style: TextStyle(
            color: isDark ? cs.onSurface.withOpacity(0.7) : null,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isDark ? cs.onSurface.withOpacity(0.6) : null,
        ),
      ),
    );
  }
}
