import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/images/cubit/image_cubit.dart';
import 'package:najran/widgets/cards/image_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ImageCubit>().fetchImages();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ImageCubit>().fetchImages(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<ImageCubit>().refreshImages();
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'البوم الصور',
      currentIndex: 3,
      child: BlocBuilder<ImageCubit, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ImageError) {
            return Center(child: Text('Erreur: ${state.message}'));
          }

          if (state is ImageLoaded) {
            final images = state.images;
            final hasReachedMax = state.hasReachedMax;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: images.length + (hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= images.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final image = images[index];
                  return ImageCard(imageModel: image);
                },
              ),
            );
          }

          if (state is ImageLoadingMore) {
            final cubit = context.read<ImageCubit>();
            final images = cubit.images;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index >= images.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final image = images[index];
                  return ImageCard(imageModel: image);
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
