import 'package:mizan_app/Models/Installment_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InstallmentDatabase {
  static String tableName = 'installments';
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
    String dbpath = join(path, 'installments.db');
    return await openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          installment REAL,
          time TEXT,
          notes TEXT
        )''');
      },
    );
  }

  Future<void> insertData(Installment installment) async {
    Database db = await getdatabase();
    await db.insert(tableName, installment.toMap());
  }

  Future<List<Installment>> getData() async {
    Database db = await getdatabase();
    List<Map<String, dynamic>> data = await db.query(tableName);
    return List.generate(data.length, (i) {
      return Installment(
        id: data[i]['id'],
        installment: data[i]['installment'],
        time: data[i]['time'],
        notes: data[i]['notes'],
      );
    });
  }

  Future<void> update(Installment installment) async {
    Database db = await getdatabase();
    await db.update(
      tableName,
      installment.toMap(),
      where: 'id=?',
      whereArgs: [installment.id],
    );
  }

  Future<void> deleteInstallment(int id) async {
    final db = await getdatabase();
    await db.delete('installments', where: 'id = ?', whereArgs: [id]);
  }
}
