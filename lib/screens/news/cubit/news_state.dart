part of 'news_cubit.dart';

sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsLoadingMore extends NewsState {}

final class NewsLoaded extends NewsState {
  final List<News> news;
  final bool hasReachedMax;

  NewsLoaded({required this.news, required this.hasReachedMax});
}

final class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});
}
