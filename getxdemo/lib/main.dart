import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/count.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  final CountController countController = CountController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() {
              return Text(
                countController.count == null
                    ? 'null'
                    : countController.count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              );
            })
            // GetBuilder<CountController>(
            //     init: countController,
            //     builder: (controller) {
            //       return Text(
            //         controller.count.toString(),
            //         style: Theme.of(context).textTheme.headline4,
            //       );
            //     }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
