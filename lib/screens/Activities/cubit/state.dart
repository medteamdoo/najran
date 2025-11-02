part of 'cubit.dart';

sealed class ActivitiesState {}

final class ActivitiesInitialState extends ActivitiesState {}

final class ActivitiesLoadingState extends ActivitiesState {}

final class ActivitiesLoadedState extends ActivitiesState {}

final class ActivitiesError extends ActivitiesState {
  final String message;

  ActivitiesError({required this.message});
}
