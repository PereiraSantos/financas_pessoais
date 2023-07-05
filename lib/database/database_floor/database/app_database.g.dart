// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FinanceDao? _financeDaoInstance;

  OutgoingDao? _outgoingDaoInstance;

  CategoryDao? _categoryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `finance` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `value` REAL, `date_start` TEXT, `date_finish` TEXT, `value_save` REAL, `active` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `outgoing` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `value` REAL, `date` TEXT, `color` INTEGER, `id_finance` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `color` INTEGER, `icon` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FinanceDao get financeDao {
    return _financeDaoInstance ??= _$FinanceDao(database, changeListener);
  }

  @override
  OutgoingDao get outgoingDao {
    return _outgoingDaoInstance ??= _$OutgoingDao(database, changeListener);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$FinanceDao extends FinanceDao {
  _$FinanceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _financeInsertionAdapter = InsertionAdapter(
            database,
            'finance',
            (Finance item) => <String, Object?>{
                  'id': item.id,
                  'value': item.value,
                  'date_start': item.dateStart,
                  'date_finish': item.dateFinish,
                  'value_save': item.valueSave,
                  'active': item.active == null ? null : (item.active! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Finance> _financeInsertionAdapter;

  @override
  Future<List<Finance>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM finance',
        mapper: (Map<String, Object?> row) => Finance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateStart: row['date_start'] as String?,
            dateFinish: row['date_finish'] as String?,
            valueSave: row['value_save'] as double?,
            active:
                row['active'] == null ? null : (row['active'] as int) != 0));
  }

  @override
  Future<Finance?> findLastAll() async {
    return _queryAdapter.query('SELECT * FROM finance order by id desc limit 1',
        mapper: (Map<String, Object?> row) => Finance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateStart: row['date_start'] as String?,
            dateFinish: row['date_finish'] as String?,
            valueSave: row['value_save'] as double?,
            active:
                row['active'] == null ? null : (row['active'] as int) != 0));
  }

  @override
  Future<Finance?> findFinanceById(int id) async {
    return _queryAdapter.query('SELECT * FROM finance where id = ?1',
        mapper: (Map<String, Object?> row) => Finance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateStart: row['date_start'] as String?,
            dateFinish: row['date_finish'] as String?,
            valueSave: row['value_save'] as double?,
            active: row['active'] == null ? null : (row['active'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<Finance?> findFinanceDateFinishIsNull() async {
    return _queryAdapter.query(
        'SELECT * FROM finance where date_finish is null and active = 1 limit 1',
        mapper: (Map<String, Object?> row) => Finance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateStart: row['date_start'] as String?,
            dateFinish: row['date_finish'] as String?,
            valueSave: row['value_save'] as double?,
            active:
                row['active'] == null ? null : (row['active'] as int) != 0));
  }

  @override
  Future<Finance?> updateDateFinanceById(
    String dateFinish,
    bool active,
    int id,
  ) async {
    return _queryAdapter.query(
        'UPDATE finance set date_finish = ?1, active = ?2 where id = ?3',
        mapper: (Map<String, Object?> row) => Finance(
            id: row['id'] as int?,
            value: row['value'] as double?,
            dateStart: row['date_start'] as String?,
            dateFinish: row['date_finish'] as String?,
            valueSave: row['value_save'] as double?,
            active: row['active'] == null ? null : (row['active'] as int) != 0),
        arguments: [dateFinish, active ? 1 : 0, id]);
  }

  @override
  Future<void> updateDateFinance(
    double value,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE finance set value = ?1 where id = ?2',
        arguments: [value, id]);
  }

  @override
  Future<void> deleteFinanceById(int id) async {
    await _queryAdapter
        .queryNoReturn('delete FROM finance WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertFinance(Finance finance) {
    return _financeInsertionAdapter.insertAndReturnId(
        finance, OnConflictStrategy.abort);
  }
}

class _$OutgoingDao extends OutgoingDao {
  _$OutgoingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _outgoingInsertionAdapter = InsertionAdapter(
            database,
            'outgoing',
            (Outgoing item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'value': item.value,
                  'date': item.date,
                  'color': item.color,
                  'id_finance': item.idFinance
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Outgoing> _outgoingInsertionAdapter;

  @override
  Future<List<Outgoing>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM outgoing',
        mapper: (Map<String, Object?> row) => Outgoing(
            id: row['id'] as int?,
            description: row['description'] as String?,
            value: row['value'] as double?,
            date: row['date'] as String?,
            color: row['color'] as int?,
            idFinance: row['id_finance'] as int?));
  }

  @override
  Future<List<Outgoing>> findAllIdFinance(int idFinance) async {
    return _queryAdapter.queryList(
        'SELECT * FROM outgoing where id_finance = ?1 order by id desc limit 5',
        mapper: (Map<String, Object?> row) => Outgoing(
            id: row['id'] as int?,
            description: row['description'] as String?,
            value: row['value'] as double?,
            date: row['date'] as String?,
            color: row['color'] as int?,
            idFinance: row['id_finance'] as int?),
        arguments: [idFinance]);
  }

  @override
  Future<List<Outgoing>> findAllOutgoingByIdFinance(int idFinance) async {
    return _queryAdapter.queryList(
        'SELECT * FROM outgoing where id_finance = ?1',
        mapper: (Map<String, Object?> row) => Outgoing(
            id: row['id'] as int?,
            description: row['description'] as String?,
            value: row['value'] as double?,
            date: row['date'] as String?,
            color: row['color'] as int?,
            idFinance: row['id_finance'] as int?),
        arguments: [idFinance]);
  }

  @override
  Future<List<Outgoing>> findOutgoingDescription(String text) async {
    return _queryAdapter.queryList(
        'SELECT * FROM outgoing WHERE description LIKE ?1',
        mapper: (Map<String, Object?> row) => Outgoing(
            id: row['id'] as int?,
            description: row['description'] as String?,
            value: row['value'] as double?,
            date: row['date'] as String?,
            color: row['color'] as int?,
            idFinance: row['id_finance'] as int?),
        arguments: [text]);
  }

  @override
  Future<void> deleteOutgoingById(int id) async {
    await _queryAdapter
        .queryNoReturn('delete FROM outgoing WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<Outgoing?> findOutgoingById(int id) async {
    return _queryAdapter.query('SELECT * FROM outgoing WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Outgoing(
            id: row['id'] as int?,
            description: row['description'] as String?,
            value: row['value'] as double?,
            date: row['date'] as String?,
            color: row['color'] as int?,
            idFinance: row['id_finance'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> updateOutgoing(
    String description,
    double value,
    String date,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update outgoing set description = ?1,  value = ?2, date = ?3 WHERE id = ?4',
        arguments: [description, value, date, id]);
  }

  @override
  Future<int> insertOutgoing(Outgoing outgoing) {
    return _outgoingInsertionAdapter.insertAndReturnId(
        outgoing, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertOutgoingList(List<Outgoing> outgoing) async {
    await _outgoingInsertionAdapter.insertList(
        outgoing, OnConflictStrategy.abort);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'color': item.color,
                  'icon': item.icon
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  @override
  Future<List<Category>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            description: row['description'] as String?,
            color: row['color'] as int?,
            icon: row['icon'] as String?));
  }

  @override
  Future<Category?> findCategoryById(int id) async {
    return _queryAdapter.query('SELECT * FROM category where id = ?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            description: row['description'] as String?,
            color: row['color'] as int?,
            icon: row['icon'] as String?),
        arguments: [id]);
  }

  @override
  Future<Category?> updateCategoryById(
    String description,
    int color,
    int id,
  ) async {
    return _queryAdapter.query(
        'UPDATE category set description = ?1, color = ?2 where id = ?3',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            description: row['description'] as String?,
            color: row['color'] as int?,
            icon: row['icon'] as String?),
        arguments: [description, color, id]);
  }

  @override
  Future<void> deleteCategoryById(int id) async {
    await _queryAdapter
        .queryNoReturn('delete FROM category WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertCategory(Category category) {
    return _categoryInsertionAdapter.insertAndReturnId(
        category, OnConflictStrategy.abort);
  }
}
