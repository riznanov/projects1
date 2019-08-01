// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wedding_planner/db/db_provider.dart';
import 'package:wedding_planner/model/categori_model.dart';
import 'package:wedding_planner/model/check_model.dart';
import 'package:wedding_planner/model/task_model.dart';
import 'package:wedding_planner/model/todo_model.dart';

class TodoListModel extends Model {
  // ObjectDB db;
  var _db = DBProvider.db;
  List<Todo> get todos => _todos.toList();
  List<Task> get tasks => _tasks.toList();
  List<Categori> get categoris => categoris.toList();
  List<Check> get checks => _checks.toList();

  int getTaskCompletionPercent(Task task) => _taskCompletionPercentage[task.id];
  int getTotalTodosFrom(Task task) => todos.where((it) => it.parent == task.id).length;
  int getCategoriCompletionPercent(Categori categori) => _categoriCompletionPercentage[categori.id];
  int getTotalChecksFrom(Categori categori) => checks.where((it) => it.parent == categori.id).length;
 
 bool get isLoading => _isLoading;
  bool _isLoading = false;
  List<Task> _tasks = [];
  List<Todo> _todos = [];
  List<Check> _checks = [];
  List<Categori> _categoris = [];

  Map<String, int> _taskCompletionPercentage =  Map();
  Map<String, int> _categoriCompletionPercentage =  Map();


  static TodoListModel of(BuildContext context) =>
      ScopedModel.of<TodoListModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    _isLoading = true;
    loadTodos();
    notifyListeners();
  }

  void loadTodos() async {
    var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      await _db.insertBulkTask(_db.tasks);
      await _db.insertBulkTodo(_db.todos);
      await _db.insertBulkCategori(_db.categoris);
      await _db.insertBulkCheck(_db.checks);
      
    }

    _tasks = await _db.getAllTask();
    _todos = await _db.getAllTodo();
    _categoris = await _db.getAllCategori();
    // _checks = await _db.getAllCheck();
    _tasks.forEach((it) => _calcTaskCompletionPercent(it.id));
    _isLoading = false;
    await Future.delayed(Duration(milliseconds: 300));
    notifyListeners();
  }

  @override
  void removeListener(listener) {
    super.removeListener(listener);
    print("remove listner called");
    // DBProvider.db.closeDB();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _calcTaskCompletionPercent(task.id);
    _db.insertTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _db.removeTask(task).then((_) {
      _tasks.removeWhere((it) => it.id == task.id);
      _todos.removeWhere((it) => it.parent == task.id);
      notifyListeners();
    });
  }

  void addCategori(Categori categori) {
    _categoris.add(categori);
    // _calcCategoriCompletionPercent(categori.id);
    _db.insertCategori(categori);
    notifyListeners();
  }

  void removeCategori(Categori categori) {
    _db.removeCategori(categori).then((_) {
      _categoris.removeWhere((it) => it.id == categori.id);
      // _todos.removeWhere((it) => it.parent == categori.id);
      notifyListeners();
    });
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((it) => it.id == todo.id);
    _syncJob(todo);
    _db.removeTodo(todo);
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    _syncJob(todo);
    _db.insertTodo(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);

    _syncJob(todo);
    _db.updateTodo(todo);

    notifyListeners();
  }
   _syncJob(Todo todo) {
    _calcTaskCompletionPercent(todo.parent);
   // _syncTodoToDB();
  }

   void removeCheck(Check check) {
    _checks.removeWhere((it) => it.id == check.id);
    _syncJobss(check);
    _db.removeCheck(check);
    notifyListeners();
  }

  void addCheck(Check check) {
    _checks.add(check);
    _syncJobss(check);
    _db.insertCheck(check);
    notifyListeners();
  }

  void updateCheck(Check check) {
    var oldCheck= _checks.firstWhere((it) => it.id == check.id);
    var replaceIndex = _checks.indexOf(oldCheck);
    _checks.replaceRange(replaceIndex, replaceIndex + 1, [check]);

    _syncJobss(check);
    _db.updateCheck(check);

    notifyListeners();
  }

  _syncJobss(Check check) {
    // _calcTaskCompletionPercent(check.parent);
   // _syncTodoToDB();
  }


  void _calcTaskCompletionPercent(String taskId) {
    var todos = this.todos.where((it) => it.parent == taskId);
    var totalTodos = todos.length;

    if (totalTodos == 0) {
      _taskCompletionPercentage[taskId] = 0;
    } else {
      var totalCompletedTodos = todos.where((it) => it.isCompleted == 1).length;
     _taskCompletionPercentage[taskId] = (totalCompletedTodos / totalTodos * 100).toInt();
    }
  }
 void _calcCategoriCompletionPercent(String categoriId) {
    var checks = this.checks.where((it) => it.parent == categoriId);
    var totalChecks = checks.length;

    if (totalChecks == 0) {
      _categoriCompletionPercentage[categoriId] = 0;
    } else {
      var totalCompletedChecks = checks.where((it) => it.isCompleted == 1).length;
     _categoriCompletionPercentage[categoriId] = (totalCompletedChecks / totalChecks * 100).toInt();
    }
  }

}
