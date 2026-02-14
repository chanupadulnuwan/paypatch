import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _activityCard(
            theme,
            title: 'Trip to Bali',
            subtitle: 'You paid \$200.50 • Split with 6 members',
            icon: Icons.flight_takeoff,
          ),
          const SizedBox(height: 10),
          _activityCard(
            theme,
            title: 'Office Lunch',
            subtitle: 'You owe \$50.00 • Added by Kasun',
            icon: Icons.restaurant,
          ),
          const SizedBox(height: 10),
          _activityCard(
            theme,
            title: 'Roommates',
            subtitle: 'Settlement reminder • Due this week',
            icon: Icons.home,
          ),
        ],
      ),
    );
  }

  Widget _activityCard(ThemeData theme,
      {required String title, required String subtitle, required IconData icon}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
