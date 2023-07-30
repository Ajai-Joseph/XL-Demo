import 'package:get/get.dart';

class CountController extends GetxController {
  final RxInt count = 0.obs;
  increment() {
    count.value++;
  }
}
