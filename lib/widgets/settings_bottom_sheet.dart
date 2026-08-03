import 'package:flutter/material.dart';
import 'package:tryes_counter/core/theme/theme_manager.dart';

class SettingsBottomSheet extends StatefulWidget {
  final Future<String> Function() onRebindKey;
  final String boundKeyName;

  const SettingsBottomSheet({
    super.key,
    required this.onRebindKey,
    required this.boundKeyName,
  });

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  bool _isRebinding = false;
  late String _currentKeyName;

  @override
  void initState() {
    super.initState();
    _currentKeyName = widget.boundKeyName;
  }

  Future<void> _handleRebind() async {
    setState(() {
      _isRebinding = true;
    });
    final newKey = await widget.onRebindKey();
    if (mounted) {
      setState(() {
        _currentKeyName = newKey;
        _isRebinding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.6,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.keyboard),
                title: const Text('Bound Key'),
                subtitle: Text('Current: $_currentKeyName'),
                trailing: ElevatedButton(
                  onPressed: _isRebinding ? null : _handleRebind,
                  child: Text(_isRebinding ? 'Press a key...' : 'Change'),
                ),
              ),
              const Divider(height: 30),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemeManager.instance,
                builder: (context, themeMode, child) {
                  final isDarkMode = themeMode == ThemeMode.dark;
                  return ListTile(
                    leading: Icon(
                        isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        ThemeManager.instance.toggleTheme(value);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
