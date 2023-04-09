import 'model/musteri.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String? id;
String? ad;
String? soyAd;
String? telefon;
String? adres;
String? sozlesmeBaslangicTarihi;
int? sozlesmeSuresi;
String? not;

class DatabaseHelper {
  static final _databaseName = "emlak.db";
  static final _databaseVersion = 1;
  static final table = 'musteri_table';
  static final columnId = 'id';
  static final columnad = 'ad';
  static final columnsoyAd = 'soyAd';
  static final columntelefon = 'telefon';
  static final columnadres = 'adres';
  static final columnsozlesmeBaslangicTarihi = 'sozlesmeBaslangicTarihi';
  static final columnsozlesmeSuresi = 'sozlesmeSuresi';
  static final columnnot = 'not';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''CREATE TABLE $table (
      '$columnId' INTEGER PRIMARY KEY AUTOINCREMENT , 
      '$columnad' TEXT NOT NULL , 
      '$columnsoyAd' TEXT NOT NULL,
      '$columntelefon' TEXT NOT NULL , 
      '$columnadres' TEXT ,
      '$columnsozlesmeBaslangicTarihi' TEXT , 
      '$columnsozlesmeSuresi' INTEGER,
      '$columnnot' TEXT 
    )  ''');
  }

  Future<int> insert(Musteri musteri) async {
    Database db = await instance.database;
    return await db.insert(table, {
      'ad': musteri.ad,
      'soyad': musteri.soyAd,
      'telefon': musteri.telefon,
      'adres': musteri.adres,
      'sozlesmeBaslangicTarihi': musteri.sozlesmeBaslangicTarihi,
      'sozlesmeSuresi': musteri.sozlesmeSuresi,
      'not': musteri.not,
    });
  }

  Future<int> update(Musteri musteri) async {
    Database db = await instance.database;
    int id = musteri.toMap()['id'];
    return await db
        .update(table, musteri.toMap(), where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
