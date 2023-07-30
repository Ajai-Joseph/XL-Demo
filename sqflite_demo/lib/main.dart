import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbController controller = Get.put(DbController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(hintText: 'name'),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: controller.ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'age'),
            ),
            SizedBox(
              height: 30,
            ),
            Obx(
              () => Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await controller.addData();
                      },
                      child: Text('Add')),
                  SizedBox(
                    width: 30,
                  ),
                  if (controller.updateId.value != (-1))
                    ElevatedButton(
                        onPressed: () async {
                          await controller.updateData();
                        },
                        child: Text('Update')),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.dataModelList[index].name),
                        subtitle: Text(
                            controller.dataModelList[index].age.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.updateId.value =
                                      controller.dataModelList[index].id;
                                  controller.nameController.text =
                                      controller.dataModelList[index].name;
                                  controller.ageController.text = controller
                                      .dataModelList[index].age
                                      .toString();
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await controller.deleteData(
                                      controller.dataModelList[index].id);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.dataModelList.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DbController);
  }
}
