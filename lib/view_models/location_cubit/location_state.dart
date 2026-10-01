part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationsLoading extends LocationState {}

final class LocationsLoaded extends LocationState {
  final List<LocationModel> locations;
  LocationsLoaded({required this.locations});
}

final class LoactionsLoadingError extends LocationState {
  final String message;
  LoactionsLoadingError({required this.message});
}

final class AddingLocation extends LocationState {}

final class AddedLocation extends LocationState {
  AddedLocation();
}

final class AddingLocationError extends LocationState {
  final String message;
  AddingLocationError({required this.message});
}

final class LocationSelectedTemporary extends LocationState {}

final class LocationSelectedConfirmed extends LocationState {
  final bool isChnaged;
  LocationSelectedConfirmed(this.isChnaged);
}

final class LocationSelectedConfirming extends LocationState {}

final class LocationSelectedConfirmingError extends LocationState {
  final String message;
  LocationSelectedConfirmingError({required this.message});
}
