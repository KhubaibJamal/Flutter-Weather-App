import 'package:geocoding/geocoding.dart';

class LocationConverter {
  String latitude = '';
  String longitude = '';
  void getLatLng(String countryName) async {
    try {
      List<Location> locations = await locationFromAddress(countryName);
      latitude = locations.last.latitude.toString();
      longitude = locations.last.longitude.toString();
    } catch (e) {
      print('ERROR: $e');
    }
  }
}
