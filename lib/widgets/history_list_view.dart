import 'package:flutter/material.dart';

class MapAttempt {
  final String mapName;
  final int attempts;
  final DateTime date;

  MapAttempt(
      {required this.mapName, required this.attempts, required this.date});
}

class HistoryListView extends StatelessWidget {
  final List<MapAttempt> attempts;

  const HistoryListView({super.key, required this.attempts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: attempts.length,
      itemBuilder: (context, index) {
        final attempt = attempts[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Text(attempt.mapName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              'Completed on: ${attempt.date.day}/${attempt.date.month}/${attempt.date.year}'),
          trailing: Text(
            '${attempt.attempts} attempts',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
