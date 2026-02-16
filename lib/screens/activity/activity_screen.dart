import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    const pageBg = Color.fromARGB(255, 245, 251, 245);

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(title: const Text('Activity')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _activityCard(
            cs,
            title: 'Trip to Bali',
            subtitle: 'You paid \$200.50 • Split with 6 members',
            icon: Icons.flight_takeoff,
          ),
          const SizedBox(height: 10),
          _activityCard(
            cs,
            title: 'Office Lunch',
            subtitle: 'You owe \$50.00 • Added by Kasun',
            icon: Icons.restaurant,
          ),
          const SizedBox(height: 10),
          _activityCard(
            cs,
            title: 'Roommates',
            subtitle: 'Settlement reminder • Due this week',
            icon: Icons.home,
          ),
          const SizedBox(height: 10),
          _activityCard(
            cs,
            title: 'Weekend Getaway',
            subtitle: 'New expense added • Taxi fare',
            icon: Icons.directions_car,
          ),
        ],
      ),
    );
  }

  Widget _activityCard(
    ColorScheme cs, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      color: const Color.fromARGB(255, 245, 251, 245),
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
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
