import 'package:geolocator/geolocator.dart';
import 'package:hand_by_hand_app/data/source/location_service.dart';
import 'package:hand_by_hand_app/service_locator.dart.dart';

class LocationModel {
  final double lon, lat;

  LocationModel({required this.lon, required this.lat});
}

final LocationService locationService = getIt<LocationService>();

Future<LocationModel> getCurrentLocation() async {
  try {
    Position position = await locationService.getCurrentLocation();
    double lon = position.longitude;
    double lat = position.latitude;
    return LocationModel(lon: lon, lat: lat);
  } catch (e) {
    return LocationModel(lon: 0, lat: 0);
  }
}
