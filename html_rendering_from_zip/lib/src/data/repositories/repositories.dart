import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ApiFunctions {
  Future<List<int>> getZippedData() async {
    try {
      final response = await Dio().get(
          'https://dashboard-xli.s3.ap-south-1.amazonaws.com/14-05-2023/Alphabet_with_picture.zip',
          options: Options(responseType: ResponseType.bytes));
      if (response.statusCode == 200) {
        log('///////');

        List<int> list = response.data as List<int>;

        return list;
      } else {
        throw Exception();
      }
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());
      log(e.toString());
      throw Exception();
    }
  }
  // Future<List<int>> getZippedData() async {
  //   try {
  //     FilePickerResult? f = await FilePicker.platform.pickFiles();
  //     File t = File(f!.files.first.path!);
  //     List<int> fileBytes = await t.readAsBytes();
  //     return fileBytes;
  //   } catch (e) {
  //     Get.snackbar('something went wrong', e.toString());
  //     log(e.toString());
  //     throw Exception();
  //   }
  // }
}
