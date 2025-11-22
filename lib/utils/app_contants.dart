


class AppConstants{
  //-------------- base url set here ---------------------//

  static const String BASE_URL="https://legier.sakibahmad.com";



  // static String get APP_NAME => dotenv.env['APP_NAME'] ?? 'DefaultAppName';
  // static String get Publishable_key => dotenv.env['STRIPE_PUBLIC_KEY'] ?? '';
  // static String get Secret_key => dotenv.env['STRIPE_SECRET_KEY'] ?? '';

  // Shared preferences keys


  // share preference Key
  static String THEME ="theme";
  static String FONTFAMILY ="Inter";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  // static List<LanguageModel> languages = [
  //   LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
  //   LanguageModel(languageName: 'French', countryCode: 'FR', languageCode: 'fr'),
  // ];

}