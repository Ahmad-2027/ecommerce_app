class ApiPaths {
  static String users(String userid) => 'users/$userid';
  static String paymentMethod(String userid, String paymentMethodId) =>
      'users/$userid/paymentMethods/$paymentMethodId';
  static String address(String userid, String addressId) =>
      'users/$userid/addresses/$addressId';
  static String addresses(String userid,) =>
      'users/$userid/addresses/';
  static String paymentMethods(String userid) =>
      'users/$userid/paymentMethods/';
  static String cartItems(String userid) => 'users/$userid/cart/';
  static String cartItem({
    required String userid,
    required String cartItemId,
  }) => 'users/$userid/cart/$cartItemId';
  static String products = 'products/';
  static String announcements = 'announcements/';
  static String categories = 'categories/';
  static String favProductItem(String userId, {required String favId}) =>
      'users/$userId/favProducts/$favId';
  static String favProducts(String userId) => 'users/$userId/favProducts/';
  static String product(String productid) => 'products/$productid';
}
