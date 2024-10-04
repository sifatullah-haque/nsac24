import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider with ChangeNotifier {
  CameraController? _controller;
  bool _isCameraInitialized = false;

  CameraController? get controller => _controller;
  bool get isCameraInitialized => _isCameraInitialized;

  Future<void> initializeCamera(CameraDescription camera) async {
    _controller = CameraController(camera, ResolutionPreset.high);

    try {
      await _controller?.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      print("Error initializing camera: $e");
      _isCameraInitialized = false;
    }
  }

  void disposeCamera() {
    _controller?.dispose();
    _isCameraInitialized = false;
    notifyListeners();
  }
}
