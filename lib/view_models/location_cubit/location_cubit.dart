import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final authServices = AuthServicesImp();
  final checkoutServices = CheckoutServicesImpl();
  String? selectedLocationid;
  Future<void> getLocations() async {
    try {
      emit(LocationsLoading());
      final locations = await checkoutServices.fetchLocations(
        authServices.currentUser()!.uid,
      );
      if (locations.isEmpty) {
        emit(LoactionsLoadingError(message: "No locations added"));
      } else {
        emit(LocationsLoaded(locations: locations));
      }
    } catch (e) {
      emit(LoactionsLoadingError(message: e.toString()));
    }
  }

  Future<void> addLocation(String location) async {
    try {
      emit(AddingLocation());
      final userId = authServices.currentUser()!.uid;
      List<LocationModel> locations = await checkoutServices.fetchLocations(
        userId,
      );
      final bool isSelected = locations.isEmpty;
      final result = location.trim().split(',');
      final newlocation = LocationModel(
        id: DateTime.now().toIso8601String(),
        city: result[0],
        country: result[1],
        isSelected: isSelected,
      );
      await checkoutServices.addNewAddress(userId, newlocation);
      locations.add(newlocation);
      emit(AddedLocation());
      emit(LocationsLoaded(locations: locations));
      if (isSelected) {
        emit(LocationSelectedConfirmed(true));
      }
    } catch (e) {
      emit(AddingLocationError(message: e.toString()));
    }
  }

  void locationSelectedTemporaray(String selectedId) {
    selectedLocationid = selectedId;
    emit(LocationSelectedTemporary());
  }

  Future<void> locationSelectedConfirmed() async {
    try {
      emit(LocationSelectedConfirming());
      final userId = authServices.currentUser()!.uid;
      List<LocationModel> locations = await checkoutServices.fetchLocations(
        userId,
      );
      if (locations.length == 1) {
        emit(LocationSelectedConfirmed(false));
      } else {
        LocationModel selectedloctiond = locations.firstWhere(
          (element) => element.id == selectedLocationid,
        );
        LocationModel previousSelectedLocation = locations.firstWhere(
          (element) => element.isSelected == true,
        );
        if (selectedLocationid == previousSelectedLocation.id) {
          emit(LocationSelectedConfirmed(false));
        } else {
          previousSelectedLocation = previousSelectedLocation.copyWith(
            isSelected: false,
          );
          selectedloctiond = selectedloctiond.copyWith(isSelected: true);
          await checkoutServices.addNewAddress(userId, selectedloctiond);
          await checkoutServices.addNewAddress(
            userId,
            previousSelectedLocation,
          );

          emit(LocationSelectedConfirmed(true));
          emit((LocationsLoaded(locations: locations)));
        }
      }
    } catch (e) {
      emit(LocationSelectedConfirmingError(message: e.toString()));
    }
  }
}
