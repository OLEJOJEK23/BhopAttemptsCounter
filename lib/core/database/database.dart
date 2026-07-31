import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class MapRuns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mapName => text()();
  IntColumn get attempts => integer()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [MapRuns])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'bhop_stats');
  }

  // Метод для сохранения забега
  Future<int> saveRun(String map, int count) {
    return into(mapRuns).insert(
      MapRunsCompanion.insert(
        mapName: map,
        attempts: count,
        date: DateTime.now(),
      ),
    );
  }

  // Метод для получения истории (стрим, чтобы интерфейс обновлялся сам)
  Stream<List<MapRun>> watchAllRuns() {
    return (select(mapRuns)..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])).watch();
  }
}
