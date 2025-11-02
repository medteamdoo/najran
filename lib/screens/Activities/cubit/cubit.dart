import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/activities.dart';
import 'package:najran/services/auth_service.dart';

part 'state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final OdooApiService odooApiService;

  void init() {
    fetchActivities();
  }

  List<Activities> _activities = [];
  ActivitiesCubit({required this.odooApiService})
    : super(ActivitiesInitialState());

  List<Activities> get activities => _activities;

  Future<void> fetchActivities() async {
    emit(ActivitiesInitialState());
    try {
      _activities.clear();
      final response = await odooApiService.getModelData(
        model: '/api/v1/followup/stats',
      );

      final result = response['result'];
      final dataList = List<Map<String, dynamic>>.from(result['data'] ?? []);
      final newItems = dataList
          .map((json) => Activities.fromJson(json))
          .toList();

      _activities.addAll(newItems);
      if (!isClosed) {
        emit(ActivitiesLoadedState());
      }
    } catch (e) {
      if (!isClosed) {
        emit(ActivitiesError(message: e.toString()));
      }
    }
  }
}
