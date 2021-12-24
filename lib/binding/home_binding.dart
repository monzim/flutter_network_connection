import 'package:flutter_network_connection/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionStatusController>(
      () => ConnectionStatusController(),
    );
  }
}
