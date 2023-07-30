import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  RxInt seconds = 0.obs;
  RxBool isRunning = false.obs;
  Timer? timer;

  void startTimer() {
    if (isRunning.value == false) {
      isRunning.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        seconds.value++;
      });
    }
  }

  void stopTimer() {
    isRunning.value = false;
    timer?.cancel();
  }

  void resetTimer() {
    seconds.value = 0;
    stopTimer();
  }
}
