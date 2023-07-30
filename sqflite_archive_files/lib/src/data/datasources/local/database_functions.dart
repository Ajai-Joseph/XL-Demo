import 'dart:developer';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../../domain/models/local_model_class/local_model_class.dart';
import '../../repositories/repositories.dart';

class DataBaseFunctions {
  Database? _db;

  int loadItemLimit = 5;
  Future<void> initDataBase() async {
    try {
      _db = await openDatabase(
        'zipped_data.db',
        version: 1,
        onCreate: (db, version) async {
          db.execute(
              'CREATE TABLE zipdata (id INTEGER PRIMARY KEY,name TEXT, file BLOB)');

          db.execute('CREATE TABLE extracteddata (path TEXT)');
        },
      );
    } catch (e) {
      Get.snackbar('something went wrong', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addDetails() async {
    try {
      if (_db == null) {
        await initDataBase();
      }

      List<File> fileList = await takeFile();
      if (fileList.isNotEmpty) {
        List<int>? compressedFile = await getCompressedData(fileList);
        await _db!.rawInsert('INSERT INTO zipdata (name,file) VALUES (?,?)',
            ['dataList', compressedFile]);
        Get.snackbar('Success', 'Data converted to zip and stored successfully',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('something went wrong', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<int>?> getCompressedData(List<File> fileList) async {
    final archive = Archive();

    for (var element in fileList) {
      final fileBytes = await element.readAsBytes();

      archive.addFile(ArchiveFile(element.path, fileBytes.length, fileBytes));
    }
    final zipEncoder = ZipEncoder();
    List<int>? compressedData = zipEncoder.encode(archive);
    return compressedData;
  }

  Future<Directory> getExtractedData() async {
    if (_db == null) {
      await initDataBase();
    }
    List<int> compressedData = await ApiFunctions().getZippedData();

    final zipDecoder = ZipDecoder();
    Archive archive = zipDecoder.decodeBytes(compressedData);

    Directory cacheDir = await getTemporaryDirectory();
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        List<int> data = file.content as List<int>;
        File newFile = File('${cacheDir.path}/$filename');

        await newFile.create(recursive: true);
        await newFile.writeAsBytes(data);
      } else {
        Directory('${cacheDir.path}/$filename').create(recursive: true);
      }
    }

    return cacheDir;
  }

  void insertExtractedData(Directory dir) async {
    if (_db == null) {
      await initDataBase();
    }
    DirectoryModel directoryModel = DirectoryModel(path: dir.path);
    await _db!.insert('extracteddata', directoryModel.toMap());

    Get.snackbar(
        'Success', 'Zip file extracted and stored in local successfully',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<List<File>> takeFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> fileList = [];
      for (PlatformFile platformFile in result.files) {
        File file = File(platformFile.path!);
        fileList.add(file);
      }
      return fileList;
    } else {
      return [];
    }
  }
}
