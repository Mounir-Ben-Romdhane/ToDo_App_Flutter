import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

  final GetStorage _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemetoBox(bool isDarkMode)=> _box.write(_key, isDarkMode);

  bool _laodThemeFromBox()=> _box.read<bool>(_key) ?? false;

  ThemeMode get theme => _laodThemeFromBox()? ThemeMode.dark : ThemeMode.light;

  void switchMode()
  {
    Get.changeThemeMode(_laodThemeFromBox()? ThemeMode.light : ThemeMode.dark);
    _saveThemetoBox(!_laodThemeFromBox());
  }

}
