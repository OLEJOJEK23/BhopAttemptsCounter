import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryes_counter/features/attempt_counter/key_polling_counter.dart';
import 'package:tryes_counter/features/map_log_watcher/map_log_watcher.dart';
import 'package:tryes_counter/widgets/history_list_view.dart';
import 'package:tryes_counter/widgets/info_card.dart';
import 'package:tryes_counter/widgets/rotating_settings_icon.dart';
import 'package:tryes_counter/widgets/settings_bottom_sheet.dart';

import '../core/blocks/theme/theme_cubit.dart';

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
  final TextEditingController _searchController = TextEditingController();

  final List<MapAttempt> _testHistory = [
    MapAttempt(
        mapName: 'bhop_sahara_v2',
        attempts: 128,
        date: DateTime.now().subtract(const Duration(days: 1))),
    MapAttempt(
        mapName: 'bhop_arcane',
        attempts: 74,
        date: DateTime.now().subtract(const Duration(days: 2))),
    MapAttempt(
        mapName: 'bhop_japan_fix',
        attempts: 256,
        date: DateTime.now().subtract(const Duration(days: 3))),
    MapAttempt(
        mapName: 'bhop_monster_jam',
        attempts: 42,
        date: DateTime.now().subtract(const Duration(days: 4))),
    MapAttempt(
        mapName: 'bhop_abyss',
        attempts: 312,
        date: DateTime.now().subtract(const Duration(days: 5))),
    MapAttempt(
        mapName: 'bhop_space_race',
        attempts: 99,
        date: DateTime.now().subtract(const Duration(days: 6))),
    MapAttempt(
        mapName: 'bhop_utopia',
        attempts: 150,
        date: DateTime.now().subtract(const Duration(days: 7))),
  ];

  @override
  void initState() {
    super.initState();
    _mapLogWatcher = MapLogWatcher(
      logFilePath:
          'C:/Program Files (x86)/Steam/steamapps/common/Counter-Strike Global Offensive/game/csgo/console.log',
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

  Future<String> _rebindKey() async {
    final newKeyName = await _keyPollingCounter.startRebinding();
    setState(() {
      _boundKeyName = newKeyName;
    });
    return newKeyName;
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SettingsBottomSheet(
          onRebindKey: _rebindKey, boundKeyName: _boundKeyName),
    );
  }

  @override
  void dispose() {
    _mapSubscription?.cancel();
    _mapLogWatcher.dispose();
    _keyPollingCounter.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.map_outlined),
        title: Row(children: [
          const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text('Bhop Counter')),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  hintText: 'Search...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      icon:
                          Icon(Icons.clear, color: Colors.grey[600], size: 20),
                      onPressed: () => _searchController.clear()),
                ),
              ),
            ),
          ),
        ]),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: IconButton(
              key: ValueKey<bool>(context.watch<ThemeCubit>().state.isDark),
              icon: Icon(
                context.watch<ThemeCubit>().state.isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                size: 24,
              ),
              tooltip: context.watch<ThemeCubit>().state.isDark
                  ? 'Переключить на светлую тему'
                  : 'Переключить на тёмную тему',
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ),
          RotatingSettingsIcon(onPressed: _showSettings),
          const SizedBox(width: 8)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: InfoCard(
                        icon: Icons.leaderboard_outlined,
                        title: 'Maps Tracked',
                        child: Text('7',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500)))),
                const SizedBox(width: 16),
                Expanded(
                    child: InfoCard(
                        icon: Icons.calculate_outlined,
                        title: 'Total Attempts',
                        child: Text('961',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w500)))),
                const SizedBox(width: 16),
                Expanded(
                  child: InfoCard(
                    icon: Icons.repeat_one,
                    title: 'Current map',
                    child: Text(
                      _currentMap ?? 'Waiting for map...',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('History',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: HistoryListView(attempts: _testHistory),
            ),
          ],
        ),
      ),
    );
  }
}
