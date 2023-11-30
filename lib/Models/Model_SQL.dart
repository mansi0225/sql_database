import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DataSQL {
  int id;
  String name;
  String dob;
  String email;
  String mobileNumber;
  String skills;
  String projectdetalis;
  String hob;
  String linked;
  String education;

  DataSQL({
    required this.id,
    required this.name,
    required this.dob,
    required this.email,
    required this.mobileNumber,
    required this.skills,
    required this.projectdetalis,
    required this.hob,
    required this.linked,
    required this.education,
  });

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE resumedata(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    dob TEXT NOT NULL,
    email TEXT NOT NULL,
    mobileNumber TEXT NOT NULL,
    skills TEXT NOT NULL,
    projectdetalis TEXT NOT NULL,
    hob TEXT NOT NULL,
    linked TEXT NOT NULL,
    educationdetalis TEXT NOT NULL)
    """);
  }

  static Future<sql.Database> db() async {
    // final path = await getDatabasesPath();
    return sql.openDatabase('resume.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
      String name,
      String dob,
      String email,
      String mobileNumber,
      String skills,
      String projectd,
      String hob,
      String linked,
      String education) async {
    final db = await DataSQL.db();

    final data = {
      'name': name,
      'dob': dob,
      'email': email,
      'mobileNumber': mobileNumber,
      'skills': skills,
      'projectdetalis': projectd,
      'hob': hob,
      'linked': linked,
      'educationdetalis': education
    };
    final id = await db.insert('resumedata', data,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getitems() async {
    final db = await DataSQL.db();
    return db.query('resumedata', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getitm(int id) async {
    final db = await DataSQL.db();
    return db.query('resumedata', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id,
      String name,
      String dob,
      String email,
      String mobileNumber,
      String skills,
      String projectd,
      String hob,
      String linked,
      String education) async {
    final db = await DataSQL.db();

    final data = {
      'name': name,
      'dob': dob,
      'email': email,
      'mobileNumber': mobileNumber,
      'skills': skills,
      'projectdetalis': projectd,
      'hob': hob,
      'linked': linked,
      'educationdetalis': education
    };

    final result =
        await db.update('resumedata', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deletItem(int id) async {
    final db = await DataSQL.db();

    try {
      await db.delete("resumedata", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went deleting an item: $err");
    }
  }
}
