import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserserviceRequestInformation
{

  LatLng?    AddressLatLang;

  String?  selected_service;
  String?    beauticianId;
  String?         userName;
  String?          userPhone;
  String?         userAddress;

  UserserviceRequestInformation({
    this.AddressLatLang,
    this.selected_service,
    this.beauticianId,
    this.userName,
    this.userPhone,
    this.userAddress,
});
}