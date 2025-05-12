import 'package:mizan_app/Models/login_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlhelper {
  static String tableName = 'user';
  static Database? _database;

  Future<Database> getdatabase() async {
    if (_database == null) {
      _database = await initialdatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> initialdatabase() async {
    String path = await getDatabasesPath();
    String dbpath = join(path, 'notes.db');
    return await openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
          name TEXT,
          email TEXT,
          income REAL,
          balance REAL,
          country TEXT
        )''');
      },
    );
  }

  Future<void> insertOrUpdate(LoginModel user) async {
    Database db = await getdatabase();
    final data = await db.query(tableName);

    if (data.isEmpty) {
      await db.insert(tableName, user.toMap());
    } else {
      await db.update(tableName, user.toMap());
    }
  }

  Future<LoginModel?> getUser() async {
    Database db = await getdatabase();
    List<Map<String, dynamic>> data = await db.query(tableName);

    if (data.isNotEmpty) {
      final user = data.first;
      return LoginModel(
        name: user['name'] ?? '',
        email: user['email'] ?? '',
        income: double.tryParse(user['income'].toString()) ?? 0.0,
        balance: double.tryParse(user['balance'].toString()) ?? 0.0,
        country: user['country'] ?? '',
      );
    } else {
      return null;
    }
  }

  Future<void> deleteUser() async {
    Database db = await getdatabase();
    await db.delete(tableName);
  }
}
