import 'package:flutter/cupertino.dart';

import '../models/directions.dart';


class AppInfo extends ChangeNotifier
{
  Directions? userHomeLocation;

  void updateHomeLocationAddress(Directions userHomeAddress)
  {
    userHomeLocation = userHomeAddress;
    notifyListeners();
  }
}