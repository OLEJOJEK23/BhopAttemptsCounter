import 'dart:async';
import 'package:win32/win32.dart';
import 'package:tryes_counter/core/win32/is_csgo_focused.dart';

class KeyPollingCounter {
  int _counter = 0;
  final _controller = StreamController<int>.broadcast();
  Stream<int> get attemptStream => _controller.stream;

  Timer? _pollTimer;
  int _targetVkCode = VK_LMENU;
  bool _wasKeyDown = false;
  bool isEnabled = false;

  void setTargetKey(int vkCode) {
    _targetVkCode = vkCode;
  }

  void init() {
    _pollTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      _checkKeyState();
    });
  }

  void _checkKeyState() {
    if (!isEnabled) return;

    try {
      final state = GetAsyncKeyState(_targetVkCode);
      final isKeyDown = (state & 0x8000) != 0;

      if (isKeyDown && !_wasKeyDown) {
        // --- ЗАЩИТА ОТ ALT+TAB ---
        Timer(const Duration(milliseconds: 150), () {
          final tabState = GetAsyncKeyState(VK_TAB);
          final isTabDown = (tabState & 0x8000) != 0;
          if (!isTabDown && isCsgoInForeground()) {
            _counter++;
            _controller.add(_counter);
          }
        });
      }

      _wasKeyDown = isKeyDown;
    } catch (e) {
      print('Ошибка при опросе состояния клавиши: $e');
    }
  }

  void reset() {
    _counter = 0;
    _controller.add(_counter);
  }

  void dispose() {
    _pollTimer?.cancel();
    _controller.close();
  }
}
