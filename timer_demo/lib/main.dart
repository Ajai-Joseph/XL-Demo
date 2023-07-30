import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_demo/time_contoller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Timer demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimerWidget(),
          TimerWidget(),
          TimerWidget(),
          TimerWidget(),
        ],
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  TimerWidget({Key? key}) : super(key: key);

  final TimerController controller = TimerController();

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Obx(() => Text(formatTime(controller.seconds.value)))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => controller.startTimer(),
                icon: Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () => controller.stopTimer(),
                icon: Icon(Icons.stop),
              ),
              IconButton(
                onPressed: () => controller.resetTimer(),
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(HomeScreen(), arguments: 'hello world');
          },
          child: Text('Go to Home'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String arguments;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text(arguments),
      ),
    );
  }
}