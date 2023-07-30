import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sqflite_archive_files/src/data/datasources/local/database_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('API Test'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await DataBaseFunctions().addDetails();
                },
                child: Text('Get files and zip')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Directory dir = await DataBaseFunctions().getExtractedData();
                  DataBaseFunctions().insertExtractedData(dir);
                },
                child: Text('Get zip and extract'))
          ],
        ));
  }
}
