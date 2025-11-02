part of 'cubit.dart';

sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {}

final class CityError extends CityState {
  final String message;

  CityError({required this.message});
}
