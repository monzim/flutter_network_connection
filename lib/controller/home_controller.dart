import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionStatusController extends GetxController {
  RxBool isConnectedToNetwork = false.obs;
  RxString deviceConnectionStatus = 'checking'.obs;
  Rx<MaterialColor> connectionStatusColor = Colors.green.obs;
  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
    if (result == ConnectivityResult.wifi) {
      isConnectedToNetwork.value = false;
      deviceConnectionStatus.value = 'wifi';
      connectionStatusColor.value = Colors.green;
      _showNotificationMessageWhenConnected();
    } else if (result == ConnectivityResult.mobile) {
      isConnectedToNetwork.value = false;
      deviceConnectionStatus.value = 'Mobile';
      connectionStatusColor.value = Colors.green;
      _showNotificationMessageWhenConnected();
    } else if (result == ConnectivityResult.ethernet) {
      isConnectedToNetwork.value = false;
      deviceConnectionStatus.value = 'Ethernet';
      connectionStatusColor.value = Colors.green;
      _showNotificationMessageWhenConnected();
    } else if (result == ConnectivityResult.none) {
      isConnectedToNetwork.value = true;
      deviceConnectionStatus.value = 'Offline';
      connectionStatusColor.value = Colors.red;
      _showNotificationMessageWhenDisconnected();
    } else {
      isConnectedToNetwork.value = true;
      deviceConnectionStatus.value = 'Error';
      connectionStatusColor.value = Colors.orange;
      _showNotificationMessageWhenDisconnected();
    }
  }

  void _showNotificationMessageWhenConnected() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      deviceConnectionStatus.value + ' Connection established',
      'Your device is connected with ' +
          deviceConnectionStatus.value +
          ' network',
      // backgroundColor: connectionStatusColor.value,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      icon: Icon(
        connectionStatus.value == ConnectivityResult.wifi
            ? Icons.wifi
            : connectionStatus.value == ConnectivityResult.mobile
                ? Icons.network_cell
                : connectionStatus.value == ConnectivityResult.ethernet
                    ? Icons.network_wifi
                    : Icons.ac_unit_sharp,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.decelerate,
      shouldIconPulse: false,
    );
  }

  void _showNotificationMessageWhenDisconnected() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      'Device network connection lost',
      'Please check your internet connection',
      // backgroundColor: connectionStatusColor.value,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 50000),
      icon: connectionStatus.value == ConnectivityResult.none
          ? const Icon(Icons.network_check_rounded)
          : Container(),
      isDismissible: false,
      showProgressIndicator: isConnectedToNetwork.value == true ? false : true,
      progressIndicatorBackgroundColor: Colors.black,
      progressIndicatorValueColor:
          AlwaysStoppedAnimation(connectionStatusColor.value),
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }

  Widget showBar() => LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          connectionStatusColor.value,
        ),
        backgroundColor: Colors.black,
      );

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
