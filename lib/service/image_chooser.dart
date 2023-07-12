import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ycsh/service/file_chooser.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/image_sourcepicker.dart';

class ImageChooser{

  static ImageChooser? _instance;

  final ImagePicker _picker=ImagePicker();
  ImageChooser._();

  factory ImageChooser() {
    return _instance??=ImageChooser._();
  }

  Future<String?> _chooseImage(ImageSource source) async{
    var file=await _picker.pickImage(source: source,
      imageQuality: AppInteger.IMAGE_QUALITY,);
    String? path=file?.path;
    return path;
  }

  Future<String?> cropImage(String path) async{
    var file=await ImageCropper().cropImage(sourcePath: path,);
    String? img_path=file?.path;
    return img_path;
  }

  void pickImage(BuildContext context,Function(String path,PickType pickType) onPickImage,
      {bool isPdfAvailable=false,}) async{
    String? source=await AppDialog.showBottomPanel<String?>(context, ImageSourcePicker(
      isPdfFileAvailable: isPdfAvailable,));

    if(source!=null) {
      if(source==AppString.TEXT_FILE){
        String? path = await FileChooser().chooseSingleFile();
        try{
          onPickImage(path!,PickType.TYPE_FILE);
        }
        catch(ex){
          AppMessage.showMessage(AppString.TEXT_NO_FILE_SELECTED);
        }
      }
      else {
        String? path = await _chooseImage(source == AppString.TEXT_IMAGE_CAMERA ?
        ImageSource.camera : ImageSource.gallery);
        try {
          String? cropped_image = await cropImage(path!);
          onPickImage(cropped_image ?? path,PickType.TYPE_IMAGE);
          //onPickImage(path!);
        }
        catch (ex) {
          AppMessage.showMessage(AppString.TEXT_NO_IMAGE_SELECTED);
        }
      }
    }
  }

}

enum ImageType{
  TYPE_ASSET,TYPE_FILE,TYPE_NETWORK
}

enum PickType{
  TYPE_FILE,TYPE_IMAGE
}