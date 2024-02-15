// import 'package:brokees/src/utilities/logger.dart';
import 'dart:io';

import 'package:contacts_app/core/logger.dart';
import 'package:contacts_app/theme/text_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


//packages used :
//https://pub.dev/packages/file_picker ,
//https://pub.dev/packages/image_cropper/install
//https://pub.dev/packages/image_picker/install

class FilePickerService {
  Future<File?> pickFile(
      {FileType fileType = FileType.image,
      List<String> allowedExtensions = const []}) async {
    try {
      // FilePicker.platform.clearTemporaryFiles();
      final result = (await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
      ));
      if (result == null) return null;
      return File(result.files.first.path!);
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    return null;
  }

  Future<File?> pickFromCamera() async {
    try {
      final result = await cameraPicker.pickImage(source: ImageSource.camera);
      if (result == null) return null;
      return File(result.path);
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    return null;
  }

  ImagePicker cameraPicker = ImagePicker();

  Future<File?> pickImage({
    double? width,
    double? height,
    List<CropAspectRatioPreset>? aspectRatio,
    ImageSource imageSource = ImageSource.gallery,
    bool crop = true,
  }) async {
    File? imageFile;
    switch (imageSource) {
      case ImageSource.camera:
        imageFile = await pickFromCamera();
        break;
      case ImageSource.gallery:
        imageFile = await pickFile();
        break;
    }
    if (imageFile == null) return null;
    logInfo("Picked file ${imageFile.lengthSync()}");
    if (crop) {
      final croppedImagePath = await cropImage(imageFile,
          maxWidth: width, maxHeight: height, aspectRatio: aspectRatio);
      return croppedImagePath;
    } else {
      return imageFile;
    }
  }

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void _logException(String message) {
    logInfo(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<File?> cropImage(File imageFile,
      {double? maxWidth,
      double? maxHeight,
      List<CropAspectRatioPreset>? aspectRatio}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      maxWidth: maxWidth?.toInt() ?? 200,
      maxHeight: maxHeight?.toInt() ?? 200,
      sourcePath: imageFile.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: aspectRatio ?? [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          // rectHeight: 1,
          // rectWidth: 1,
          resetButtonHidden: true,
          // rectHeight: 2,
          // rectWidth: 16,
          aspectRatioPickerButtonHidden: false,
          title: 'Crop Image',

          aspectRatioLockEnabled: true,
          aspectRatioLockDimensionSwapEnabled: true,
          rotateButtonsHidden: true,
        )
      ],
    );
    if (croppedFile == null) return null;
    File croppd = File(croppedFile.path);
    logInfo("cropped  ${croppd.lengthSync()}");
    return croppd;
  }

  Future<ImageSource?> showImageSourceBottomSheet(BuildContext context) async {
    //ImageSource? imageSource = await ActionSheetImagePicker().showActionSheet(context);
    // return imageSource;
    ImageSource? imageSource = await showCupertinoModalPopup(
        context: context,
        builder: (context) => const CupertinoActionSheetWidget());

    // showModalBottomSheet(
    //   // shape: const RoundedRectangleBorder(
    //   //   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    //   // ),
    //   context: context,
    //   builder: (context) => const ImageSourceBottomSheet(),
    // );
    // await Get.bottomSheet(const ImageSourceBottomSheet());
    return imageSource;
  }
}

class CupertinoActionSheetWidget extends StatelessWidget {
  const CupertinoActionSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text('Select Image', style: heading1.blackgrey),
      message: Text('From one of the options', style: heading2.blackgrey),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, ImageSource.camera);
          },
          child: Text('Take Photo Now', style: heading1.primary),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, ImageSource.gallery);

            // Navigator.pop(context);
          },
          child: Text('Choose from Gallery', style: heading1.primary),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: heading1.red)),
    );
  }
}
