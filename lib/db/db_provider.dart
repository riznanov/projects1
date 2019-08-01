import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:wedding_planner/model/categori_model.dart';
import 'package:wedding_planner/model/check_model.dart';
import 'package:wedding_planner/model/task_model.dart';
import 'dart:io';

import 'package:wedding_planner/model/todo_model.dart';

class DBProvider {
  static Database _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  var todos = [
    Todo("Membuat dan menentukan rencana biaya untuk rangkaian acara pernikahan", parent: '1',),
    Todo("Menentukan konsep pernkahan", parent: '1', isCompleted: 1),
    Todo("Menentukan tamu undangan", parent: '2',),
    Todo("Menentukan tanggal pernikahan", parent: '2',),
    Todo("Menentukan vanue pernikahan", parent: '2',),
    Todo("Menentukan alur pernikahan", parent: '3',),
    Todo("Menentukan Tema pernikahan", parent: '3',),
    Todo("Menentukan & booking dekorasi", parent: '3',),
    Todo("Menentukan & booking dress & attire", parent: '3',),
    Todo("Menentukan & booking make-up artist, hair do / hijab do", parent: '3',),
    Todo("Lengkapi dokumen yang diperlukan untuk mendaftar di KUA atau catatan sipil", parent: '4',),
    Todo("Datangi KUA atau kantor catatan sipil terdekat", parent: '4',),
    Todo("Menentukan & booking Fotografer dan Videografer", parent: '4',),
    Todo("Menentukan & booking catering ", parent: '4',),
    Todo("Memesan undangan pernikahan ", parent: '4',),
    Todo("Menentukan undangan yang jadi dan fix diundang ", parent: '4',),
    Todo("Melakukan foto pre wedding", parent: '5',),
    Todo("Menentukan & pesan souvenir", parent: '5',),
    Todo("Menentukan & pesan florist", parent: '5',),
    Todo("Menentukan & pesan cake pernikahan", parent: '5',),
    Todo("Menentukan pengisi acara", parent: '5',),
    Todo("Menentukan Bridesmaid & Bestman", parent: '6',),
    Todo("Menentukan Pagar ayu & pagar bagus", parent: '6',),
    Todo("Menentukan orang-orang yang terlibat dalam pernikahan (among tamu, penerima tamu)", parent: '6',),
    Todo("Menentukan Dress dan accesoris untuk bridesmaid dan bestman", parent: '6',),
    Todo("Menentukan Dress dan accesoris untuk pagar ayu dan pagar bagus", parent: '6',),
    Todo("Memberikan kain untuk bridesmaid & bestman", parent: '6',),
    Todo("Menentukan Dress dan accesoris untuk keluarga", parent: '6',),
    Todo("Memesan cincin pernikahan", parent: '6',),
    Todo("Memesan seserahan dan mahar", parent: '6',),
    Todo("Testing rasa makanan catering", parent: '6',),
    Todo("Memetakan vanue pernikahan", parent: '7',),
    Todo("Membentuk tim dan penanggung jawab setiap alur acara pernikahan", parent: '7',),
    Todo("Mengadakan meeting untuk team yang membantu", parent: '7',),
    Todo("Membuat timeline acara", parent: '7',),
    Todo("Menentukan Sound & perlengkapan acara", parent: '7',),
    Todo("Tes Kesehatan", parent: '7',),
    Todo("Mulai menyebar undangan", parent: '7',),
    Todo("Mengurus perijinan pernikahan", parent: '8',),
    Todo("Fitting Baju", parent: '8',),
    Todo("Mengecek semua vendor yang terlibat", parent: '8',),
    Todo( "Ambil pesanan cincin kawin, pastikan grafirnya benar sesuai pesanan", parent: '8',),
    Todo( "Susun jadwal acara pernikahan, gandakan dan bagikan kepada keluarga pengantin, panitia, fotografer dan videografer", parent: '9',),
    Todo( "Konfirmasikan jumlah undangan kepada vendor katering", parent: '9',),
    Todo( "Konfirmasikan semua pesanan", parent: '9',),
    Todo( "Melakukan perawatan untuk kulit dan wajah", parent: '9',),
    Todo( "Melakukan perawatan spa sebelum hari pernikahan", parent: '10',),
    Todo( "Yakinkan diri semua akan berjalan dengan semestinya", parent: '10',),
    Todo( "Berdoa, berserah diri kepada Tuhan", parent: '10',),
  ];

  var tasks = [
    Task('8 Bulan Sebelum Pernikahan', id: '1', color: Colors.pink.value, codePoint: Icons.fitness_center.codePoint),
    Task('7 Bulan Sebelum Pernikahan', id: '2', color: Colors.blue.value, codePoint: Icons.fitness_center.codePoint),
    Task('6 Bulan Sebelum Pernikahan', id: '3', color: Colors.green.value, codePoint: Icons.fitness_center.codePoint),
    Task('5 Bulan Sebelum Pernikahan', id: '4', color: Colors.lime.value, codePoint: Icons.fitness_center.codePoint),
    Task('4 Bulan Sebelum Pernikahan', id: '5', color: Colors.yellow.value, codePoint: Icons.fitness_center.codePoint),
    Task('3 Bulan Sebelum Pernikahan', id: '6', color: Colors.orange.value, codePoint: Icons.fitness_center.codePoint),
    Task('2 Bulan Sebelum Pernikahan', id: '7', color: Colors.teal.value, codePoint: Icons.fitness_center.codePoint),
    Task('1 Bulan Sebelum Pernikahan', id: '8', color: Colors.red.value, codePoint: Icons.fitness_center.codePoint),
    Task('3 - 2 Minggu Sebelum Pernikahan', id: '9', color: Colors.red.value, codePoint: Icons.fitness_center.codePoint),
    Task('1 Minggu Sebelum Pernikahan', id: '10', color: Colors.red.value, codePoint: Icons.fitness_center.codePoint),
   ];

  var categoris = [
    Categori('Tempat Acara', id: '1', codePoint: Icons.arrow_right.codePoint),
    Categori('Dekorasi', id: '2', codePoint: Icons.arrow_right.codePoint),
    Categori('Makanan', id: '3', codePoint: Icons.arrow_right.codePoint),
    Categori('Make Up & Hair Do / Hijab Do', id: '4', codePoint: Icons.arrow_right.codePoint),
    Categori('Gaun / Busana Pengantin', id: '5', codePoint: Icons.arrow_right.codePoint),
    Categori('Bunga', id: '6', codePoint: Icons.arrow_right.codePoint),
    Categori('Kue Pengantin', id: '7', codePoint: Icons.arrow_right.codePoint),
    Categori('Mobil Pengantin', id: '8', codePoint: Icons.arrow_right.codePoint),
    Categori('Dokumentasi', id: '9', codePoint: Icons.arrow_right.codePoint),
    Categori('Kartu Undangan', id: '10', codePoint: Icons.arrow_right.codePoint),
    Categori('Souvenir', id: '11', codePoint: Icons.arrow_right.codePoint),
    Categori('Entertainment', id: '12', codePoint: Icons.arrow_right.codePoint),
    Categori('Pendukung Acara', id: '13', codePoint: Icons.arrow_right.codePoint),
    Categori('Catatan Sipil', id: '14', codePoint: Icons.arrow_right.codePoint),
    Categori('Lain - Lain', id: '15', codePoint: Icons.arrow_right.codePoint),
    Categori('Tim Pendukung', id: '16', codePoint: Icons.arrow_right.codePoint),
  ];
 var checks = [
    Check("Tempat Upacara Pernikahan", parent:'1', isCompleted: 1),
    Check("Tempat Resepsi", parent:'1',),
    Check("Dekorasi tempat upacara pernikahan", parent:'2',),
    Check("Dekorasi Pelaminan", parent:'2',),
    Check("Dekorasi Rumah", parent:'2',),
    Check("Catering Upacara Pernikahan", parent:'3',),
    Check("Catering Resepsi", parent:'3',),
    Check("Catering Dirumah", parent:'3',),
    Check("Test Make UP", parent:'4',),
    Check("Make UP untuk Mempelai Wanita", parent:'4',),
    Check("Make UP untuk Mempelai Pria", parent:'4',),
    Check("Make UP untuk  Keluarga Mempelai Wanita", parent:'4',),
    Check("Make UP untuk Keluarga Mempelai Pria", parent:'4',),
    Check("Make UP untuk Bridesmaid", parent:'4',),
    Check("Make UP untuk Penerima Tamu", parent:'4',),
    Check("Make UP untuk Pagar Ayu", parent:'4',),
    Check("Make UP untuk Flower Girl", parent:'4',),
    Check("Gaun Pengantin", parent:'5',),
    Check("Accesoris Pengantin Wanita", parent:'5',),
    Check("Jas Pengantin Pria", parent:'5',),
    Check("Accesoris Pengantin Pria", parent:'5',),
    Check("Gaun Bridemaid", parent:'5',),
    Check("Accesoris Bridesmaid", parent:'5',),
    Check("Jas Bestman", parent:'5',),
    Check("Accesoris Bestman", parent:'5',),
    Check("Gaun Ibu (Keluarga Pria & Wanita)", parent:'5',),
    Check("Jas Ayah (Keluarga Pria & Wanita)", parent:'5',),
    Check("Gaun Pagar Ayu", parent:'5',),
    Check("Penerima Tamu", parent:'5',),
    Check("Flower Girl", parent:'5',),
    Check("Hand Bouquet Tangan / Dipegang", parent:'6',),
    Check("Hand Bouquet Lempar", parent:'6',),
    Check("Bunga Bridesmaid", parent:'6',),
    Check("Bunga Pagar Ayu", parent:'6',),
    Check("Corsage Pengantin (untuk dikenakan di jas)", parent:'6',),
    Check("Corsage untuk keluarga pihak pria", parent:'6',),
    Check("Corsage untuk keluarga pihak wanita", parent:'6',),
    Check("Kue untuk dinagikan setelah acara", parent:'7',),
    Check("Kue di Pelaminan", parent:'7',),
    Check("Mobil Mempelai", parent:'8',),
    Check("Transportasi Keluarga Wanita", parent:'8',),
    Check("Transportas untuk Keluarga Pria", parent:'8',),
    Check("Perijinan, keamanan & parkir tamu", parent:'8',),
    Check("Photo Prewedding", parent:'9',),
    Check("Photo Liputan", parent:'9',),
    Check("Video Prewedding", parent:'9',),
    Check("Video Liputan", parent:'9',),
    Check("Souvenir + Packing", parent:'10',),
    Check("MC Upacara Pernikahan", parent:'11',),
    Check("MC Resepsi", parent:'11',),
    Check("Music / Wedding Singer", parent:'11',),
    Check("Sound system", parent:'11',),
 ];
 
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  get _dbPath async {
    String documentsDirectory = await _localPath;
    return p.join(documentsDirectory, "Todo.db");
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  initDB() async {
    String path = await _dbPath;
    return await openDatabase(path, version: 1, onOpen: (db) {

    }, onCreate: (Database db, int version) async {
      print("DBProvider:: onCreate()");
      await db.execute("CREATE TABLE Task ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "color INTEGER,"
          "code_point INTEGER"
          ")");
      await db.execute("CREATE TABLE Todo ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "parent TEXT,"
          "completed INTEGER NOT NULL DEFAULT 0"
          ")");
      await db.execute("CREATE TABLE Categori ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "code_point INTEGER"
          ")");
      await db.execute("CREATE TABLE Check ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "parent TEXT,"
          "completed INTEGER NOT NULL DEFAULT 0"
          ")");
      
    });
  }

  insertBulkTask(List<Task> tasks) async {
    final db = await database;
    tasks.forEach((it) async {
      var res = await db.insert("Task", it.toJson());
      print("Task ${it.id} = $res");
    });
  }

  insertBulkTodo(List<Todo> todos) async {
    final db = await database;
    todos.forEach((it) async {
      var res = await db.insert("Todo", it.toJson());
      print("Todo ${it.id} = $res");
    });
  }

  insertBulkCategori(List<Categori> categoris) async {
    final db = await database;
    categoris.forEach((it) async {
      var res = await db.insert("Categori", it.toJson());
      print("Categori ${it.id} = $res");
    });
  }

  insertBulkCheck(List<Check> checks) async {
    final db = await database;
    checks.forEach((it) async {
      var res = await db.insert("Check", it.toJson());
      print("Check ${it.id} = $res");
    });
  }

  Future<List<Task>> getAllTask() async {
    final db = await database;
    var result = await db.query('Task');
    return result.map((it) => Task.fromJson(it)).toList();
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    var result = await db.query('Todo');
    return result.map((it) => Todo.fromJson(it)).toList();
  }

  Future<List<Categori>> getAllCategori() async {
    final db = await database;
    var result = await db.query('Categori');
    return result.map((it) => Categori.fromJson(it)).toList();
  }
  
  Future<List<Check>> getAllCheck()async{
    final db = await database;
    var result = await db.query('Check');
    return result.map((it) => Check.fromJson(it)).toList(); 
  }
// UPDATE
  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return db
        .update('Todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> removeTodo(Todo todo) async {
    final db = await database;
    return db.delete('Todo', where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return db.insert('Todo', todo.toJson());
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    return db.insert('Task', task.toJson());
  }

  Future<void> removeTask(Task task) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Todo', where: 'parent = ?', whereArgs: [task.id]);
      await txn.delete('Task', where: 'id = ?', whereArgs: [task.id]);
    });
  }

   Future<int> insertCategori(Categori categori) async {
    final db = await database;
    return db.insert('Categori', categori.toJson());
  }

  Future<void> removeCategori(Categori categori) async {
    final db = await database;
    return db.transaction<void>((txn) async {
      await txn.delete('Categori', where: 'id = ?', whereArgs: [categori.id]);
    });
  }

  Future<int> updateCheck(Check check) async {
    final db = await database;
    return db
        .update('Check', check.toJson(), where: 'id = ?', whereArgs: [check.id]);
  }

  Future<int> removeCheck(Check check) async {
    final db = await database;
    return db.delete('Check', where: 'id = ?', whereArgs: [check.id]);
  }

  Future<int> insertCheck(Check check) async {
    final db = await database;
    return db.insert('Check', check.toJson());
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  closeDB() {
    if (_database != null) {
      _database.close();
    }
  }
}


