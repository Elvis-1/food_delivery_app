class AppConstants {
  static const String APP_NAME = 'IFNOTFOOD';
  static const int APP_VERSION = 1;
  static const String TOKEN = '';

  static const String BASE_URI = 'http://foodapp.ifnotgod.com/';

  static const String POPULAR_PRODUCT_URI = 'api/2/popularfood';
  static const String RECOMMENDED_PRODUCT_URI = 'api/1/recommendedfood';

  static const String POPULAR_FOOD_IMAGE =
      "https://foodapp.ifnotgod.com/food_app/public/popularFood/";

  static const String RECOMMENDED_FOOD_IMAGE =
      "https://foodapp.ifnotgod.com/food_app/public/recommendedFood/";

  static const String CART_LIST = 'cart-list';
  static const String CART_HISTORY_LIST = "cart-history-list";

  // auth constants
  static const String SIGNUP_URI = 'api/signup';
  static const String SIGNIN_URI = 'api/signin';

  static const String USER_INFO_URI = 'api/user';

  static const String USER_ADDRESS = 'user_address';
  static const String ADD_USER_ADDRESS = 'api/customer/add_address';
  static const String ADDRESS_LIST_URI = 'api/customer/address_list';

  static const String GEOCODE_URI = 'api/config'; // using a mock response
  static const String ZONE_URI = 'api/customer/get-zone-id'; // not working yet
  static const String SEARCH_LOCATION_URI = 'api/places';
  static const String PLACE_DETAILS_URI = 'api/places';

  static const String PHONE = '';
  static const String PASSWORD = '';
}
