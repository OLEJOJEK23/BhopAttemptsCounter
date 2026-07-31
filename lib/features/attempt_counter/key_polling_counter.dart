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

  bool _isRebinding = false;
  Completer<String>? _rebindingCompleter;

  static final Map<int, String> _vkCodeNames = _createVkCodeMap();
  static final List<int> _rebindableKeys = _vkCodeNames.keys.toList();

  Future<String> startRebinding() {
    _isRebinding = true;
    _rebindingCompleter = Completer<String>();
    return _rebindingCompleter!.future;
  }

  void init() {
    _pollTimer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (_isRebinding) {
        _captureNextKey();
      } else {
        _checkKeyState();
      }
    });
  }

  void _captureNextKey() {
    for (final vkCode in _rebindableKeys) {
      final state = GetAsyncKeyState(vkCode);
      if ((state & 0x8000) != 0) {
        _targetVkCode = vkCode;
        _isRebinding = false;
        final keyName = _vkCodeNames[vkCode] ?? 'Unknown (Code $vkCode)';
        _rebindingCompleter?.complete(keyName);
        _rebindingCompleter = null;
        
        _wasKeyDown = true;
        return;
      }
    }
  }

  void _checkKeyState() {
    if (!isEnabled) return;
    try {
      final state = GetAsyncKeyState(_targetVkCode);
      final isKeyDown = (state & 0x8000) != 0;
      if (isKeyDown && !_wasKeyDown) {
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

  static Map<int, String> _createVkCodeMap() {
    final map = <int, String>{
      VK_LBUTTON: 'Mouse 1', VK_RBUTTON: 'Mouse 2', VK_MBUTTON: 'Mouse 3',
      VK_XBUTTON1: 'Mouse 4', VK_XBUTTON2: 'Mouse 5',
      VK_BACK: 'Backspace', VK_TAB: 'Tab', VK_RETURN: 'Enter',
      VK_SHIFT: 'Shift', VK_CONTROL: 'Ctrl', VK_MENU: 'Alt',
      VK_PAUSE: 'Pause', VK_CAPITAL: 'Caps Lock', VK_ESCAPE: 'Escape',
      VK_SPACE: 'Space', VK_PRIOR: 'Page Up', VK_NEXT: 'Page Down',
      VK_END: 'End', VK_HOME: 'Home', VK_LEFT: 'Left Arrow',
      VK_UP: 'Up Arrow', VK_RIGHT: 'Right Arrow', VK_DOWN: 'Down Arrow',
      VK_INSERT: 'Insert', VK_DELETE: 'Delete',
      VK_LWIN: 'Left Win', VK_RWIN: 'Right Win',
      VK_NUMPAD0: 'Numpad 0', VK_NUMPAD1: 'Numpad 1', VK_NUMPAD2: 'Numpad 2',
      VK_NUMPAD3: 'Numpad 3', VK_NUMPAD4: 'Numpad 4', VK_NUMPAD5: 'Numpad 5',
      VK_NUMPAD6: 'Numpad 6', VK_NUMPAD7: 'Numpad 7', VK_NUMPAD8: 'Numpad 8',
      VK_NUMPAD9: 'Numpad 9',
      VK_MULTIPLY: 'Numpad *', VK_ADD: 'Numpad +', VK_SUBTRACT: 'Numpad -',
      VK_DECIMAL: 'Numpad .', VK_DIVIDE: 'Numpad /',
      VK_F1: 'F1', VK_F2: 'F2', VK_F3: 'F3', VK_F4: 'F4', VK_F5: 'F5',
      VK_F6: 'F6', VK_F7: 'F7', VK_F8: 'F8', VK_F9: 'F9', VK_F10: 'F10',
      VK_F11: 'F11', VK_F12: 'F12',
      VK_NUMLOCK: 'Num Lock', VK_SCROLL: 'Scroll Lock',
      VK_LSHIFT: 'Left Shift', VK_RSHIFT: 'Right Shift',
      VK_LCONTROL: 'Left Ctrl', VK_RCONTROL: 'Right Ctrl',
      VK_LMENU: 'Left Alt', VK_RMENU: 'Right Alt',
    };
    // Добавляем клавиши A-Z
    for (var i = 0; i < 26; i++) {
      map[0x41 + i] = String.fromCharCode('A'.codeUnitAt(0) + i);
    }
    // Добавляем клавиши 0-9
    for (var i = 0; i < 10; i++) {
      map[0x30 + i] = String.fromCharCode('0'.codeUnitAt(0) + i);
    }
    return map;
  }
}
