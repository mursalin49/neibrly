class ApiUrl {
  static const String baseUrl = "https://naibrly-backend.onrender.com/";
  // static const String socketGlobal = "https://renti-socket.techcrafters.tech";
  static String imageUrl({String? url}) {
    return "http://192.168.10.5:5005/$url";
  }

  /// live base url
  /// http://159.223.184.53:6006/api/v1

  static const String login = "$baseUrl/provider/sign-in";
  static const String forgetPassword = "$baseUrl/auth/forget-password";
  static const String verifyOTP = "$baseUrl/auth/verify-account";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String signInEndPoint = "$baseUrl/auth/sign-up";
  static const String settings = "$baseUrl/settings";
  static const String cart = "$baseUrl/cart";
  static const String orderMy = "$baseUrl/order/my-orders";
  static const String profileUpdate = "$baseUrl/user/profile";
  static const String profile = "$baseUrl/user/profile";
  static const String cartAdd = "$baseUrl/cart/add";
  static const String allNurse = "$baseUrl/user/nurses";
  static const String chatList = "$baseUrl/chat";
  static const String appointmentCreate = "$baseUrl/appointment/create";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String createCartOrder = "$baseUrl/order/create";
  static const String deleteNotification = "$baseUrl/notification";
  static const String payment = "$baseUrl/order/make-payment";

  static const String notification =
      "$baseUrl/notification/notifications?limit=999999";

  static const String marketingMaterial =
      "$baseUrl/market-material?&limit=9999";

  static String deleteCart({required String cartId}) => "$baseUrl/cart/$cartId";

  static String getChatId({required String hireId}) =>
      "$baseUrl/chat/customer/$hireId";

  static String getMyAppointment({required String date}) =>
      "$baseUrl/appointment/get-as-patient?date=$date&limit=9999";

  static String getNurseAppointment({required String date}) =>
      "$baseUrl/appointment/get-as-nurse?date=$date&limit=9999";

  static String inventoryForPatient({required String role}) =>
      "$baseUrl/product?productFor=$role&limit=9999";
}