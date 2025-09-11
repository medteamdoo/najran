import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/video/cubit/video_cubit.dart';
import 'package:najran/widgets/cards/video_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().fetchVideos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<VideoCubit>().fetchVideos(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<VideoCubit>().refreshVideos();
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: "البوم الفيديوهات",
      currentIndex: 3,
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VideoError) {
            return Center(child: Text('Erreur: ${state.message}'));
          }

          if (state is VideoLoaded) {
            final videos = state.videos;
            final hasReachedMax = state.hasReachedMax;

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: videos.length + (hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= videos.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final video = videos[index];
                  return VideoCard(video: video);
                },
              ),
            );
          }

          if (state is VideoLoadingMore) {
            final cubit = context.read<VideoCubit>();
            final videos = cubit.videos;

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: videos.length + 1,
                itemBuilder: (context, index) {
                  if (index >= videos.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final video = videos[index];
                  return VideoCard(video: video);
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
