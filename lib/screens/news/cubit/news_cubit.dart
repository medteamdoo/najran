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

  NewsCubit({required this.odooApiService}) : super(NewsInitial());

  List<News> get news => _news;

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
      emit(NewsLoaded(news: _news, hasReachedMax: _hasReachedMax));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  void refreshNews() {
    _page = 1;
    _news.clear();
    _hasReachedMax = false;
    fetchNews();
  }
}
