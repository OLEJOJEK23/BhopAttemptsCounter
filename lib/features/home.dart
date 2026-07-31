import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tryes_counter/features/map_log_watcher/map_log_watcher.dart';
import 'package:tryes_counter/features/attempt_counter/key_polling_counter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MapLogWatcher _mapLogWatcher;
  late final KeyPollingCounter _keyPollingCounter;
  StreamSubscription? _mapSubscription;

  String? _currentMap;
  
  String _boundKeyName = 'Left Alt';
  bool _isRebinding = false;

  @override
  void initState() {
    super.initState();
    
    _mapLogWatcher = MapLogWatcher(
      logFilePath: 'C:/Program Files (x86)/Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/console.log',
    );
    
    _keyPollingCounter = KeyPollingCounter();
    _keyPollingCounter.init();

    _mapSubscription = _mapLogWatcher.mapNameStream.listen((mapName) {
      setState(() {
        _currentMap = mapName;
      });
      _keyPollingCounter.reset();
      _keyPollingCounter.isEnabled = true;
    });
  }

  /// Метод, который запускает процесс перепривязки
  Future<void> _rebindKey() async {
    setState(() {
      _isRebinding = true;
    });

    // Ждем, пока пользователь нажмет клавишу
    final newKeyName = await _keyPollingCounter.startRebinding();

    // Обновляем UI
    setState(() {
      _boundKeyName = newKeyName;
      _isRebinding = false;
    });
  }

  @override
  void dispose() {
    _mapSubscription?.cancel();
    _mapLogWatcher.dispose();
    _keyPollingCounter.dispose();
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
            const SizedBox(height: 8),
            Text(
              _currentMap ?? 'Waiting for map...',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: _currentMap != null ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            const Text('Attempts:', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            StreamBuilder<int>(
              stream: _keyPollingCounter.attemptStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              },
            ),
            const SizedBox(height: 50),
            const Divider(),
            const SizedBox(height: 20),
            Text('Bound Key: $_boundKeyName', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isRebinding ? null : _rebindKey,
              child: Text(
                _isRebinding ? 'Press any key...' : 'Change Key',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
