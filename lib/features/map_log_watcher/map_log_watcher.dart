import 'dart:async';
import 'dart:io';
import 'dart:convert';

class MapLogWatcher {
  final String logFilePath;
  int _lastSize = 0;
  Timer? _timer;
  
  // Кэш для последнего найденного имени карты
  String? _lastMapName; 

  final _controller = StreamController<String>.broadcast();

  MapLogWatcher({required this.logFilePath}) {
    _init();
  }

  // Публичный стрим, на который будет подписываться UI
  Stream<String> get mapNameStream => _controller.stream;

  void _init() async {
    final file = File(logFilePath);
    if (!await file.exists()) {
      _controller.addError('Log file not found at $logFilePath');
      await _controller.close();
      return;
    }

    _lastSize = await file.length();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _checkFile(file);
    });
  }

  Future<void> _checkFile(File file) async {
    try {
      final currentSize = await file.length();
      if (currentSize > _lastSize) {
        final stream = file.openRead(_lastSize, currentSize);
        final lines = await stream.transform(Latin1Decoder()).transform(LineSplitter()).toList();
        
        for (final rawLine in lines.reversed) {
          final line = rawLine.trim();
          final regex = RegExp(r'\[Client\] Map: "(.+?)"');
          final match = regex.firstMatch(line);
          if (match != null) {
            final mapName = match.group(1);

            if (mapName != null && mapName.startsWith('bhop_') && mapName != _lastMapName) {
              _lastMapName = mapName;
              _controller.add(mapName);
              break; 
            }
          }
        }
        _lastSize = currentSize;
      } else if (currentSize < _lastSize) {
        _lastSize = currentSize;
      }
    } catch (e) {
      _controller.addError('Error during file check: $e');
    }
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
