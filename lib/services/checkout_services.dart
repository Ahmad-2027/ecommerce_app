import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utitlities/api_paths.dart';

abstract class CheckoutServices {
  Future<void> addNewPaymentMethod(
    String userId,
    PaymentCardModel paymentMethod,
  );
  Future<List<PaymentCardModel>> fetchPaymentMethods(String userId);
  Future<void> addNewAddress(String userId, LocationModel location);
  Future<List<LocationModel>> fetchLocations(String userId);
}

class CheckoutServicesImpl implements CheckoutServices {
  final fireStoreServices = FirestoreServices.instance;
  @override
  Future<void> addNewPaymentMethod(
    String userId,
    PaymentCardModel paymentMethod,
  ) async {
    await fireStoreServices.setData(
      path: ApiPaths.paymentMethod(userId, paymentMethod.id),
      data: paymentMethod.toMap(),
    );
  }

  @override
  Future<List<PaymentCardModel>> fetchPaymentMethods(String userId) async {
    return await fireStoreServices.getCollection<PaymentCardModel>(
      path: ApiPaths.paymentMethods(userId),
      builder: (data, documnetId) => PaymentCardModel.fromMap(data),
    );
  }

  @override
  Future<void> addNewAddress(String userId, LocationModel location) async {
    await fireStoreServices.setData(
      path: ApiPaths.address(userId, location.id),
      data: location.toMap(),
    );
  }

  @override
  Future<List<LocationModel>> fetchLocations(String userId) async {
    return await fireStoreServices.getCollection<LocationModel>(
      path: ApiPaths.addresses(userId),
      builder: (data, documnetId) => LocationModel.fromMap(data),
    );

  }
}
