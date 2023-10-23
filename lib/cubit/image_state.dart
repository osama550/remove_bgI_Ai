part of 'image_cubit.dart';
abstract class ImageState {}

class ImageInitial extends ImageState {}
class getImageLoadingState extends ImageState {}
class getImageSuccessState extends ImageState {}
class getImageErrorState extends ImageState {}
class uploadImageErrorState extends ImageState {}
class uploadImageLoadingState extends ImageState {}
class uploadImageSuccessState extends ImageState {}
class CircleProgressLoadingState extends ImageState {}
