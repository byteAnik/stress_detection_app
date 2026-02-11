
import 'package:provider/provider.dart';
import 'package:stress_detection_app/provider/carosul_provider.dart';
import 'package:stress_detection_app/provider/forget_password_provider.dart';
import 'package:stress_detection_app/provider/profile_provider.dart';
import 'package:stress_detection_app/provider/singnup_provider.dart';

var providers = [
  ChangeNotifierProvider<ForgetPasswordProvider>(
    create: ((context) => ForgetPasswordProvider()),
  ),

  ChangeNotifierProvider<SignupProvider>(
    create: ((context) => SignupProvider()),
  ),

  ChangeNotifierProvider<ProfileProvider>(
    create: ((context) => ProfileProvider()),
  ),

  ChangeNotifierProvider<CarosulProvider>(
    create: ((context) => CarosulProvider()),
  ),
];
