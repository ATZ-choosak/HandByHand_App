import 'package:geolocator/geolocator.dart';
import 'package:hand_by_hand_app/module/get_location.dart';

Future<String> calculateDistance(double lat, double lon) async {
  LocationModel currentPosition = await getCurrentLocation();
  double distance = Geolocator.distanceBetween(
      currentPosition.lat, currentPosition.lat, lat, lon) / 1000;
  return distance.toStringAsFixed(2);
}
