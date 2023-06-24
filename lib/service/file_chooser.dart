import 'package:file_picker/file_picker.dart';

class FileChooser {

  static FileChooser? _instance;

  final FilePicker _picker = FilePicker.platform;

  FileChooser._();

  factory FileChooser() {
    return _instance ??= FileChooser._();
  }

  Future<String?> chooseSingleFile() async{
    var file=await _picker.pickFiles(type: FileType.custom,
      allowedExtensions: ['pdf'],);
    String? path=file?.files.single.path;
    return path;
  }

  Future<List<String>> chooseMultipleFile() async{
    var file=await _picker.pickFiles(allowMultiple: true,type: FileType.image,);
    return file?.files.map<String>((val){
      return val.path!;
    }).toList()??[];
  }



}