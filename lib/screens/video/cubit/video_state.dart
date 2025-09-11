part of 'video_cubit.dart';

sealed class VideoState {}

final class VideoInitial extends VideoState {}

final class VideoLoading extends VideoState {}

final class VideoLoadingMore extends VideoState {}

final class VideoLoaded extends VideoState {
  final List<YoutubeVideo> videos;
  final bool hasReachedMax;

  VideoLoaded({required this.videos, required this.hasReachedMax});
}

final class VideoError extends VideoState {
  final String message;

  VideoError({required this.message});
}
