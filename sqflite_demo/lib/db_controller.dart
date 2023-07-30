import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import 'model_class.dart';

class DbController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String dbPath = 'details.db';
  RxList<ModelClass> dataModelList = <ModelClass>[].obs;
  RxInt updateId = (-1).obs;

  late Database database;
  initDatabase() async {
    database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    });
  }

  getAllData() async {
    List<Map<String, dynamic>> list =
        await database.rawQuery('SELECT * FROM Test');

    List<ModelClass> dataList = [];
    list.forEach((element) {
      dataList.add(ModelClass.fromJson(element));
    });
    log('datalist $dataList');
    dataModelList.value = dataList;
  }

  addData() async {
    int id = await database.rawInsert(
        'INSERT INTO Test(name, age) VALUES(?, ?)',
        [nameController.text, ageController.text]);
    nameController.clear();
    ageController.clear();
    log(id.toString());
    getAllData();
  }

  updateData() async {
    if (updateId.value != (-1) &&
        nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty) {
      int count = await database.rawUpdate(
          'UPDATE Test SET name = ?, age = ? WHERE id = ?',
          [nameController.text, ageController.text, updateId.value]);
      updateId.value = (-1);
      nameController.clear();
      ageController.clear();
      log(count.toString());
      getAllData();
    }
  }

  Future<void> deleteData(int id) async {
    int count = await database.rawDelete('DELETE FROM Test WHERE id=?', [id]);
    log(count.toString());
    getAllData();
  }

  @override
  void onInit() async {
    await initDatabase();
    await getAllData();
    super.onInit();
  }
}
