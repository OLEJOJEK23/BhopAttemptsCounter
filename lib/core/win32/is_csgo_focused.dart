import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

/// Проверяет, является ли "Counter-Strike 2" активным окном в Windows.
bool isCsgoInForeground() {
  final foregroundWindow = GetForegroundWindow();
  final buffer = wsalloc(256);

  try {
    GetWindowText(foregroundWindow, buffer, 256);
    final windowTitle = buffer.toDartString();

    return windowTitle == 'Counter-Strike 2';
  } finally {
    free(buffer);
  }
}
