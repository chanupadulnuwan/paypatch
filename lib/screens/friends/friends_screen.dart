import 'package:flutter/material.dart';
import 'add_friend_screen.dart';


class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    Widget friendCard(String name, String subtitle) {
      return Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 10),
        color: const Color.fromARGB(255, 245, 251, 245), // soft background
        surfaceTintColor: Colors.transparent, // remove M3 tint
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: cs.outlineVariant), // gray border
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: cs.outlineVariant, // gray circle
            child: const Icon(Icons.person, color: Colors.white), // white icon
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          friendCard('Nimal Perera', 'You owe: \$20.00'),
          friendCard('Kavindi Silva', 'You get: \$45.00'),
          friendCard('Roommate Group', 'Settlements pending'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: cs.primary, 
        foregroundColor: Colors.white,
        onPressed: () {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Contact Access'),
      content: const Text(
        'This is a prototype demo.\n\nIn a real app, PayPatch would request permission to read contacts.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permission granted (demo)')),
            );
          },
          child: const Text('Allow'),
        ),
      ],
    ),
  );
},

        child: const Icon(Icons.person_add),
      ),
    );
  }
}
