// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MapRunsTable extends MapRuns with TableInfo<$MapRunsTable, MapRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MapRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mapNameMeta = const VerificationMeta(
    'mapName',
  );
  @override
  late final GeneratedColumn<String> mapName = GeneratedColumn<String>(
    'map_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, mapName, attempts, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'map_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MapRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('map_name')) {
      context.handle(
        _mapNameMeta,
        mapName.isAcceptableOrUnknown(data['map_name']!, _mapNameMeta),
      );
    } else if (isInserting) {
      context.missing(_mapNameMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MapRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MapRun(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      mapName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}map_name'],
          )!,
      attempts:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attempts'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
    );
  }

  @override
  $MapRunsTable createAlias(String alias) {
    return $MapRunsTable(attachedDatabase, alias);
  }
}

class MapRun extends DataClass implements Insertable<MapRun> {
  final int id;
  final String mapName;
  final int attempts;
  final DateTime date;
  const MapRun({
    required this.id,
    required this.mapName,
    required this.attempts,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['map_name'] = Variable<String>(mapName);
    map['attempts'] = Variable<int>(attempts);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  MapRunsCompanion toCompanion(bool nullToAbsent) {
    return MapRunsCompanion(
      id: Value(id),
      mapName: Value(mapName),
      attempts: Value(attempts),
      date: Value(date),
    );
  }

  factory MapRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MapRun(
      id: serializer.fromJson<int>(json['id']),
      mapName: serializer.fromJson<String>(json['mapName']),
      attempts: serializer.fromJson<int>(json['attempts']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mapName': serializer.toJson<String>(mapName),
      'attempts': serializer.toJson<int>(attempts),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  MapRun copyWith({int? id, String? mapName, int? attempts, DateTime? date}) =>
      MapRun(
        id: id ?? this.id,
        mapName: mapName ?? this.mapName,
        attempts: attempts ?? this.attempts,
        date: date ?? this.date,
      );
  MapRun copyWithCompanion(MapRunsCompanion data) {
    return MapRun(
      id: data.id.present ? data.id.value : this.id,
      mapName: data.mapName.present ? data.mapName.value : this.mapName,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MapRun(')
          ..write('id: $id, ')
          ..write('mapName: $mapName, ')
          ..write('attempts: $attempts, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mapName, attempts, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MapRun &&
          other.id == this.id &&
          other.mapName == this.mapName &&
          other.attempts == this.attempts &&
          other.date == this.date);
}

class MapRunsCompanion extends UpdateCompanion<MapRun> {
  final Value<int> id;
  final Value<String> mapName;
  final Value<int> attempts;
  final Value<DateTime> date;
  const MapRunsCompanion({
    this.id = const Value.absent(),
    this.mapName = const Value.absent(),
    this.attempts = const Value.absent(),
    this.date = const Value.absent(),
  });
  MapRunsCompanion.insert({
    this.id = const Value.absent(),
    required String mapName,
    required int attempts,
    required DateTime date,
  }) : mapName = Value(mapName),
       attempts = Value(attempts),
       date = Value(date);
  static Insertable<MapRun> custom({
    Expression<int>? id,
    Expression<String>? mapName,
    Expression<int>? attempts,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mapName != null) 'map_name': mapName,
      if (attempts != null) 'attempts': attempts,
      if (date != null) 'date': date,
    });
  }

  MapRunsCompanion copyWith({
    Value<int>? id,
    Value<String>? mapName,
    Value<int>? attempts,
    Value<DateTime>? date,
  }) {
    return MapRunsCompanion(
      id: id ?? this.id,
      mapName: mapName ?? this.mapName,
      attempts: attempts ?? this.attempts,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mapName.present) {
      map['map_name'] = Variable<String>(mapName.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MapRunsCompanion(')
          ..write('id: $id, ')
          ..write('mapName: $mapName, ')
          ..write('attempts: $attempts, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MapRunsTable mapRuns = $MapRunsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mapRuns];
}

typedef $$MapRunsTableCreateCompanionBuilder =
    MapRunsCompanion Function({
      Value<int> id,
      required String mapName,
      required int attempts,
      required DateTime date,
    });
typedef $$MapRunsTableUpdateCompanionBuilder =
    MapRunsCompanion Function({
      Value<int> id,
      Value<String> mapName,
      Value<int> attempts,
      Value<DateTime> date,
    });

class $$MapRunsTableFilterComposer
    extends Composer<_$AppDatabase, $MapRunsTable> {
  $$MapRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mapName => $composableBuilder(
    column: $table.mapName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MapRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $MapRunsTable> {
  $$MapRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mapName => $composableBuilder(
    column: $table.mapName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MapRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MapRunsTable> {
  $$MapRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mapName =>
      $composableBuilder(column: $table.mapName, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$MapRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MapRunsTable,
          MapRun,
          $$MapRunsTableFilterComposer,
          $$MapRunsTableOrderingComposer,
          $$MapRunsTableAnnotationComposer,
          $$MapRunsTableCreateCompanionBuilder,
          $$MapRunsTableUpdateCompanionBuilder,
          (MapRun, BaseReferences<_$AppDatabase, $MapRunsTable, MapRun>),
          MapRun,
          PrefetchHooks Function()
        > {
  $$MapRunsTableTableManager(_$AppDatabase db, $MapRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MapRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MapRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MapRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mapName = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => MapRunsCompanion(
                id: id,
                mapName: mapName,
                attempts: attempts,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mapName,
                required int attempts,
                required DateTime date,
              }) => MapRunsCompanion.insert(
                id: id,
                mapName: mapName,
                attempts: attempts,
                date: date,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MapRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MapRunsTable,
      MapRun,
      $$MapRunsTableFilterComposer,
      $$MapRunsTableOrderingComposer,
      $$MapRunsTableAnnotationComposer,
      $$MapRunsTableCreateCompanionBuilder,
      $$MapRunsTableUpdateCompanionBuilder,
      (MapRun, BaseReferences<_$AppDatabase, $MapRunsTable, MapRun>),
      MapRun,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MapRunsTableTableManager get mapRuns =>
      $$MapRunsTableTableManager(_db, _db.mapRuns);
}
