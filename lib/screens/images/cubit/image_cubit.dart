import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/image.dart';
import 'package:najran/services/auth_service.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final OdooApiService odooApiService;

  List<ImageModel> _images = [];
  int _page = 1;
  final int _pageSize = 10;
  bool _hasReachedMax = false;

  ImageCubit({required this.odooApiService}) : super(ImageInitial());

  List<ImageModel> get images => _images;

  Future<void> fetchImages({bool loadMore = false}) async {
    if (state is ImageLoading || _hasReachedMax) return;

    if (loadMore) {
      emit(ImageLoadingMore());
      _page++;
    } else {
      emit(ImageLoading());
      _page = 1;
      _hasReachedMax = false;
      _images.clear();
    }

    try {
      final response = await odooApiService.getModelData(
        model: 'news.photo',
        query: '{id,title,image_1920}',
        order: 'id desc',
        page: _page,
        pageSize: _pageSize,
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['result'] ?? []);
      final newItems = dataList
          .map((json) => ImageModel.fromJson(json))
          .toList();

      if (newItems.length < _pageSize) _hasReachedMax = true;

      _images.addAll(newItems);
      if (!isClosed) {
        emit(ImageLoaded(images: _images, hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      if (!isClosed) {
        emit(ImageError(message: e.toString()));
      }
    }
  }

  void refreshImages() {
    _page = 1;
    _images.clear();
    _hasReachedMax = false;
    fetchImages();
  }
}
