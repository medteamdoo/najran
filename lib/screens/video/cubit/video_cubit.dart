import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/video.dart';
import 'package:najran/services/auth_service.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final OdooApiService odooApiService;

  List<YoutubeVideo> _videos = [];
  int _page = 1;
  final int _pageSize = 10;
  bool _hasReachedMax = false;

  VideoCubit({required this.odooApiService}) : super(VideoInitial());

  List<YoutubeVideo> get videos => _videos;

  Future<void> fetchVideos({bool loadMore = false}) async {
    if (state is VideoLoading || _hasReachedMax) return;

    if (loadMore) {
      emit(VideoLoadingMore());
      _page++;
    } else {
      emit(VideoLoading());
      _page = 1;
      _hasReachedMax = false;
      _videos.clear();
    }

    try {
      final response = await odooApiService.getModelData(
        model: 'get/news.video',
        query: '{id,title,url}',
        order: 'id desc',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => YoutubeVideo.fromJson(json))
          .toList();

      if (newItems.length < _pageSize) _hasReachedMax = true;

      _videos.addAll(newItems);
      if (!isClosed) {
        emit(VideoLoaded(videos: _videos, hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      if (!isClosed) {
        emit(VideoError(message: e.toString()));
      }
    }
  }

  void refreshVideos() {
    _page = 1;
    _videos.clear();
    _hasReachedMax = false;
    fetchVideos();
  }
}
