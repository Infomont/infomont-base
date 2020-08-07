import 'package:sqflite/sqflite.dart';

abstract class IDBProvider {
  Future<Database> get database;
}