// ignore_for_file: unnecessary_string_escapes, equal_keys_in_map

import 'package:get/get.dart';
import 'package:stress_detection_app/localization/en.dart';
import 'package:stress_detection_app/localization/es.dart';


final class Apptranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': en,

        //Portuguese LANGUAGE
        'es_ES': es,
      };
}
