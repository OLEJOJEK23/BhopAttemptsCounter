import 'package:flutter/material.dart';
import 'package:tryes_counter/features/map_log_watcher/map_log_watcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MapLogWatcher _mapLogWatcher = MapLogWatcher(
    logFilePath: 'C:/Program Files (x86)/Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/console.log',
  );

  @override
  void dispose() {
    _mapLogWatcher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Current map:', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            StreamBuilder<String>(
              // Получаем стрим напрямую из MapLogWatcher
              stream: _mapLogWatcher.mapNameStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  );
                }
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return const Text(
                    'Waiting for map change...',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
