import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/jap_entry.dart';
import '../stores/counter_store.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CounterStore>(
            builder: (_, store, __) {
              if (store.history.isEmpty) {
                return const Center(
                  child: Text(
                    'Nothing to show',
                    style: TextStyle(fontSize: 28),
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (_, index) => _HistoryItem(
                  key: Key(store.history.hashCode.toString()),
                  japEntry: store.history[index],
                ),
                separatorBuilder: (_, __) => const Divider(
                  indent: 8,
                  endIndent: 8,
                ),
                itemCount: store.history.length,
              );
            },
          ),
        ),
      );
}

class _HistoryItem extends StatelessWidget {
  final JapEntry japEntry;
  const _HistoryItem({super.key, required this.japEntry});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd-MM-yyyy, hh:mm a').format(japEntry.timestamp);
    return ListTile(
      leading: Text(
        '${japEntry.count}',
        style: const TextStyle(fontSize: 20),
      ),
      title: Text(formattedDate, style: const TextStyle(fontSize: 20)),
      trailing: InkWell(
        onTap: () {
          Provider.of<CounterStore>(context, listen: false)
              .removeJapEntry(japEntry);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Deleted successfully'),
            ),
          );
        },
        child: Icon(
          Icons.delete,
          color: Colors.red.shade600,
        ),
      ),
    );
  }
}
