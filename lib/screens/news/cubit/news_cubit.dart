import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/news.dart';
import 'package:najran/services/auth_service.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final OdooApiService odooApiService;

  List<News> _news = [];
  int _page = 1;
  final int _pageSize = 10;
  bool _hasReachedMax = false;

  // news Emir
  List<News> _emirNews = [];
  int _emirPage = 1;
  bool _emirHasReachedMax = false;

  // deputy Emir

  List<News> _deputyEmirNews = [];
  int _deputyEmirPage = 1;
  bool _deputyEmirHasReachedMax = false;

  NewsCubit({required this.odooApiService}) : super(NewsInitial());

  List<News> get news => _news;
  List<News> get emirNews => _emirNews;
  List<News> get deputyEmirNews => _deputyEmirNews;

  Future<void> fetchNews({bool loadMore = false}) async {
    if (state is NewsLoading || _hasReachedMax) return;

    if (loadMore) {
      emit(NewsLoadingMore());
      _page++;
    } else {
      emit(NewsLoading());
      _page = 1;
      _hasReachedMax = false;
      _news.clear();
    }

    try {
      final response = await odooApiService.getModelData(
        model: 'news.news',
        query:
            '{id,title,attachment,resume,type,video_url,description_text,news_source,date_published,image_1920}',
        order: 'date_published desc',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList.map((json) => News.fromJson(json)).toList();

      if (newItems.length < _pageSize) _hasReachedMax = true;

      _news.addAll(newItems);
      if (!isClosed) {
        emit(NewsLoaded(news: _news, hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      if (!isClosed) {
        emit(NewsError(message: e.toString()));
      }
    }
  }

  void refreshNews() {
    _page = 1;
    _news.clear();
    _hasReachedMax = false;
    fetchNews();
  }

  Future<void> fetchEmirNews({bool loadMore = false}) async {
    if (state is NewsLoading || _emirHasReachedMax) return;

    if (loadMore) {
      emit(NewsLoadingMore());
      _emirPage++;
    } else {
      emit(NewsLoading());
      _emirPage = 1;
      _emirHasReachedMax = false;
      _emirNews.clear();
    }

    try {
      final response = await odooApiService.getModelData(
        model: 'news.news',
        query:
            '{id,title,attachment,resume,type,video_url,description_text,news_source,date_published,image_1920}',
        order: 'date_published desc',
        page: _emirPage,
        pageSize: _pageSize,
        filter: [
          ["news_source", "=", "prince"],
        ],
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList.map((json) => News.fromJson(json)).toList();

      if (newItems.length < _pageSize) _emirHasReachedMax = true;

      _emirNews.addAll(newItems);
      if (!isClosed) {
        emit(NewsLoaded(news: _emirNews, hasReachedMax: _emirHasReachedMax));
      }
    } catch (e) {
      if (!isClosed) {
        emit(NewsError(message: e.toString()));
      }
    }
  }

  void refreshEmirNews() {
    _emirPage = 1;
    _emirNews.clear();
    _emirHasReachedMax = false;
    fetchEmirNews();
  }

  Future<void> fetchDeputyEmirNews({bool loadMore = false}) async {
    if (state is NewsLoading || _deputyEmirHasReachedMax) return;

    if (loadMore) {
      emit(NewsLoadingMore());
      _deputyEmirPage++;
    } else {
      emit(NewsLoading());
      _deputyEmirPage = 1;
      _deputyEmirHasReachedMax = false;
      _deputyEmirNews.clear();
    }

    try {
      final response = await odooApiService.getModelData(
        model: 'news.news',
        query:
            '{id,title,attachment,resume,type,video_url,description_text,news_source,date_published,image_1920}',
        order: 'date_published desc',
        page: _deputyEmirPage,
        pageSize: _pageSize,
        filter: [
          ["news_source", "=", "deputy_prince"],
        ],
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList.map((json) => News.fromJson(json)).toList();

      if (newItems.length < _pageSize) _deputyEmirHasReachedMax = true;

      _deputyEmirNews.addAll(newItems);
      if (!isClosed) {
        emit(
          NewsLoaded(
            news: _deputyEmirNews,
            hasReachedMax: _deputyEmirHasReachedMax,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(NewsError(message: e.toString()));
      }
    }
  }

  void refreshDeputyEmirNews() {
    _deputyEmirPage = 1;
    _deputyEmirNews.clear();
    _deputyEmirHasReachedMax = false;
    fetchDeputyEmirNews();
  }
}
