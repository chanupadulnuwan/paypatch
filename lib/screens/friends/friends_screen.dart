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
        color: const Color.fromARGB(255, 245, 251, 245),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: cs.outlineVariant),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: cs.outlineVariant,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$name tapped (demo)')),
            );
          },
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
                'Please accept the request.\n\nPayPatch is request permission to read contacts.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddFriendScreen(),
                      ),
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
