import 'package:flutter/material.dart';
import '../../models/group.dart';

class GroupDetailScreen extends StatelessWidget {
  final Group group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: cs.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: group.id,
                  child: CircleAvatar(
                    radius: 36,
                    child: const Icon(Icons.groups, size: 36),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  group.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text('${group.members} members'),
                const SizedBox(height: 12),
                Text(group.description),
                const SizedBox(height: 20),
                Text(
                  group.balance >= 0
                      ? 'You get \$${group.balance.toStringAsFixed(2)}'
                      : 'You owe \$${group.balance.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: group.balance >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
