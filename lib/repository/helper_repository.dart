import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_tensorflow_lite/flutter_tensorflow_lite.dart';
import 'package:image_picker/image_picker.dart';
import '../models/classify_model.dart';

///Includes functions related to tflite and
///image picker and loading the images
///from the camera and then classifying them
class HelperRepository {
  late CameraDescription cameraDescription;

  HelperRepository({required this.cameraDescription});

  ///Load the tflite model to the ram to make further inference
  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/models/model.tflite',
        labels: 'assets/models/labels.txt');
  }

  /// Make inference form the model
  Future<ClassifyModel> _classifyImage(File image) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 4, //the amout of categories our neural network can predict
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      return ClassifyModel(file: image, output: output);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// This function  grabs the image from camera
  Future<ClassifyModel> pickImage() async {
    try {
      var image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxHeight: 500,
          imageQuality: 80,
          preferredCameraDevice: CameraDevice.rear);
      if (image == null) {
        throw Exception('Something went wrong while parsing the image');
      }
      return _classifyImage(File(image.path));
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Pick an image from the gallery and then make inference
  Future<ClassifyModel> pickGalleryImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        throw Exception('Something went wrong while parsing the image');
      }
      return _classifyImage(File(image.path));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ClassifyModel> liveImageClassification(String imagePath) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: imagePath,
        numResults: 4, //the amout of categories our neural network can predict
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      return ClassifyModel(output: output);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  closeModel() async {
    await Tflite.close();
  }
}
