import 'package:flutter/material.dart';
import '../../data/sample_data.dart';
import '../../models/group.dart';
import 'group_detail_screen.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  Group? selected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 700;

        if (isTablet) {
          return Row(
            children: [
              Expanded(child: _buildList(isTablet)),
              Expanded(
                child: selected == null
                    ? const Center(child: Text('Select a group'))
                    : GroupDetailScreen(group: selected!),
              ),
            ],
          );
        }

        return _buildList(false);
      },
    );
  }

  Widget _buildList(bool isTablet) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Groups')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleGroups.length,
        itemBuilder: (context, index) {
          final group = sampleGroups[index];

          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: cs.outlineVariant),
            ),
            child: ListTile(
              leading: Hero(
                tag: group.id,
                child: const CircleAvatar(child: Icon(Icons.groups)),
              ),
              title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${group.members} members'),
              trailing: Text(
                group.balance >= 0
                    ? '+\$${group.balance.toStringAsFixed(2)}'
                    : '-\$${group.balance.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: group.balance >= 0 ? Colors.green : Colors.red,
                ),
              ),
              onTap: () {
                if (isTablet) {
                  setState(() => selected = group);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GroupDetailScreen(group: group),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
