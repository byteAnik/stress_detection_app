import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:stress_detection_app/constants/app_constants.dart';
import 'package:stress_detection_app/helpers/di.dart';


class LanguageController extends GetxController {
  var selectedLocale = const Locale('en', 'US').obs;

  var isEnglish = true.obs;


Future<void> changeLanguage(String languageCode,String countryCode)async{
  var locale=Locale(languageCode,countryCode);
 selectedLocale.value = locale;
 Get.updateLocale(locale);
}

Future<void> setLanguage(String languageCode, String countryCode)async{
appData.write(kKeyLanguageCode, languageCode);
appData.write(kKeyCountryCode, countryCode);

}

Future<void> getLanguage()async{
  String ? languageCode=appData.read(kKeyLanguageCode);
  String ? countryCode=appData.read(kKeyCountryCode);

  log("----------------------languageCode--get--$languageCode------------------------------------");
  log("----------------------countryCode--get--$countryCode------------------------------------");

  if(languageCode !=null && countryCode !=null){
    var locale=Locale(languageCode, countryCode);
    selectedLocale.value = locale;
    Get.updateLocale(locale);

    if(languageCode == 'en' && countryCode == 'US'){
      isEnglish.value = true; 
  }
  else {
      isEnglish.value = false;
    }

}

}

  @override
  void onInit() {
    super.onInit();
    getLanguage();
  }

}