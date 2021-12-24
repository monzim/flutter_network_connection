import 'package:flutter/material.dart';
import 'package:flutter_network_connection/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<ConnectionStatusController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: const Text(
          'Network Status',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        flexibleSpace: Obx(
          () => controller.isConnectedToNetwork.value == true
              ? controller.showBar()
              : Container(),
        ),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 50,
                  height: 50,
                  color: controller.connectionStatusColor.value,
                ),
              ),
              const SizedBox(width: 10, height: 10),
              Text(
                controller.deviceConnectionStatus.value,
                // style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
