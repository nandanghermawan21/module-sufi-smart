import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sufismart/util/file_service.dart';
import 'package:sufismart/util/system.dart';

class ImagePickerComponent extends StatelessWidget {
  final ImagePickerController controller;
  final double height;
  final double width;
  final String placeHolderImageAsset;

  const ImagePickerComponent({
    Key? key,
    required this.controller,
    this.height = 120,
    this.width = 120,
    this.placeHolderImageAsset = "ssets/icon_camera.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ImagePickerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (value.imagePickerState == ImagePickerState.onInitUpload) return;
            if (value.imagePickerState == ImagePickerState.onUpload) return;
            controller.getImages();
          },
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color:
                    controller.value.imagePickerState == ImagePickerState.empty
                        ? Colors.grey
                        : Colors.grey,
              ),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/icon_camera.png",
                ),
                scale: 3,
                repeat: ImageRepeat.noRepeat,
                alignment: Alignment.center,
                fit: BoxFit.none,
              ),
            ),
            child: childBuilder(value.imagePickerState),
          ),
        );
      },
    );
  }

  Widget childBuilder(ImagePickerState imagePickerState) {
    switch (imagePickerState) {
      case ImagePickerState.onUpload:
        return progressUpload(
          totalSize: controller.value.fileSize,
          uploadedSize: controller.value.uploadedSize ?? 0,
          percentage: controller.value.percentageUpload,
        );
      case ImagePickerState.uploaded:
        return loadedImage();
      case ImagePickerState.uploadFiled:
        return const SizedBox();
      case ImagePickerState.loaded:
        return loadedImage();
      case ImagePickerState.empty:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget loadedImage() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Image.memory(
        controller.value.fileUri!.contentAsBytes(),
      ),
    );
  }

  Widget uploadedImage() {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Image.network(controller.value.uploadedUrl ?? ""),
    );
  }

  Widget progressUpload(
      {required int? totalSize,
      required int uploadedSize,
      required percentage}) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  left: (width) * 10 / 100, right: (width) * 10 / 100),
              padding: const EdgeInsets.all(2),
              width: width,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    color: System.data.color!.primaryColor,
                    width: 1,
                  )),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  width: width * percentage,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickerController extends ValueNotifier<ImagePickerValue> {
  ImagePickerController({ImagePickerValue? value})
      : super(value ?? ImagePickerValue());

  Future<ImagePickerValue> getImages({
    bool camera = true,
    int imageQuality = 100,
    int compresedQuality = 5,
  }) async {
    try {
      File _image;
      String _valueBase64Compress = "";
      Uint8List? _unit8Listcompressed;
      PickedFile? _picker;
      if (camera) {
        _picker = (await ImagePicker().pickImage(
            source: ImageSource.camera,
            imageQuality: imageQuality)) as PickedFile?;
      } else {
        _picker = (await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: imageQuality)) as PickedFile?;
      }

      _image = File(_picker!.path);

      value.fileImage = _image;
      value.fileBase64 = getExtension(_image.toString()) +
          base64.encode(_image.readAsBytesSync());
      notifyListeners();

      _unit8Listcompressed = await FlutterImageCompress.compressWithFile(
        _image.absolute.path,
        quality: compresedQuality,
      );

      _valueBase64Compress = getExtension(_image.toString()) +
          base64.encode(_unit8Listcompressed!);
      value.fileBase64Compresed = _valueBase64Compress;
      value.fileUri = Uri.parse(_valueBase64Compress).data;

      value.imagePickerState = ImagePickerState.loaded;
      commit();
      return value;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadFile({
    @required String? url,
    String? field,
    Map<String, dynamic>? header,
  }) async {
    if (value.fileImage == null) {
      value.imagePickerState = ImagePickerState.error;
      commit();
      throw "no image for upload";
    }

    value.uploadedSize = 0;
    value.fileSize = 0;
    value.imagePickerState = ImagePickerState.onInitUpload;
    commit();
    return FileServiceUtil.fileUploadMultipart(
      file: value.fileImage,
      field: field,
      url: url,
      header: header,
      onUploadProgress: (
        uploaded,
        fileSize,
      ) {
        value.imagePickerState = ImagePickerState.onUpload;
        value.uploadedSize = uploaded;
        value.fileSize = fileSize;
        commit();
      },
    ).then((result) {
      value.uploadedSize = 0;
      value.fileSize = 0;
      value.imagePickerState = ImagePickerState.uploaded;
      value.uploadedResponse = result;
      commit();
      return result;
    }).catchError((e) {
      value.imagePickerState = ImagePickerState.error;
      commit();
      throw (e);
    });
  }

  String getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String result = "";
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }

  void commit() {
    notifyListeners();
  }
}

class ImagePickerValue {
  ImagePickerState imagePickerState = ImagePickerState.empty;

  File? fileImage;
  String? fileBase64;
  String? fileBase64Compresed;
  UriData? fileUri;
  int? uploadedSize;
  int? fileSize;
  String? uploadedResponse;
  String? uploadedUrl;

  double get percentageUpload {
    return (fileSize == 0 ? 0 : ((uploadedSize ?? 0) / (fileSize ?? 0)) * 100)
        .toDouble();
  }
}

enum ImagePickerState {
  loaded,
  onInitUpload,
  onUpload,
  uploaded,
  uploadFiled,
  empty,
  error,
}
