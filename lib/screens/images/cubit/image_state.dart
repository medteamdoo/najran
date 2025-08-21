part of 'image_cubit.dart';

sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageLoadingMore extends ImageState {}

final class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  final bool hasReachedMax;

  ImageLoaded({required this.images, required this.hasReachedMax});
}

final class ImageError extends ImageState {
  final String message;

  ImageError({required this.message});
}
