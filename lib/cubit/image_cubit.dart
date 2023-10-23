import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  static ImageCubit get(context) => BlocProvider.of(context);

  File? imageFile;

  Uint8List? imagePath;

  void getImage(ImageSource source) async {
    emit(getImageLoadingState());
    try {
      final pickedImage = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);
      if (pickedImage != null) {
        imageFile = await File(pickedImage.path);

        emit(getImageSuccessState());
      }
    } catch (e) {
      imageFile = null;
      emit(getImageErrorState());
    }
  }

  void removeBg(File file) async {
    emit(uploadImageLoadingState());
    String image = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'image_file': await MultipartFile.fromFile(file.path, filename: image),
      'size': 'auto',
    });
    Dio dio = Dio();
    dio.options.headers['X-API-Key'] = '8bz38RF8ApDqaCCHwU1fDGrz';

    Response response = await dio.post(
      'https://api.remove.bg/v1.0/removebg',
      data: formData,
      options:
          Options(responseType: ResponseType.bytes), // Updated responseType
    );

    if (response.statusCode == 200) {
      print("Success>>>>>>>>>>>>>>");
      imagePath = response.data;
      print(imagePath);
      emit(uploadImageSuccessState());
    } else {
      emit(uploadImageErrorState());
      throw Exception('Error occurred with response ${response.statusCode}');
    }
  }
  // ScreenshotController controller = ScreenshotController();
  // void saveImage() async {
  //   bool isGranted = await Permission.storage.status.isGranted;
  //   if (!isGranted) {
  //     isGranted = await Permission.storage.request().isGranted;
  //   }
  //
  //   if (isGranted) {
  //     String directory = (await getExternalStorageDirectory())!.path;
  //     String fileName =
  //         DateTime.now().microsecondsSinceEpoch.toString() + ".png";
  //    controller.captureAndSave(directory, fileName: fileName);
  //   }
  // }
}
