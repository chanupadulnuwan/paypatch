import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Friends')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Nimal Perera'),
              subtitle: Text('You owe: \$20.00'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Kavindi Silva'),
              subtitle: Text('You get: \$45.00'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Roommate Group'),
              subtitle: Text('Settlements pending'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Friend (UI only)')),
          );
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
