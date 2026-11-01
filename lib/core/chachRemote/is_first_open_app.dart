// import 'dart:developer';
//
// import 'package:scholar_chat_proj/core/constants/app_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class IsFirstOpenApp {
//   static SharedPreferences? _pref;
//
//   static Future<void> initSharedStorge() async {
//     _pref = await SharedPreferences.getInstance();
//   }
//
//   static Future<void> setIsFirstOpen(bool value) async {
//     try {
//       _pref!.setBool(AppConstant.isFirstOpenApp, value);
//     } catch (error) {
//       log("error to save is first open");
//     }
//   }
//
//   static bool getIsFirstOpen() {
//     try {
//       return _pref!.getBool(AppConstant.isFirstOpenApp) ?? false;
//     } catch (error) {
//       log("error to get is first open");
//       rethrow;
//     }
//   }
// }
