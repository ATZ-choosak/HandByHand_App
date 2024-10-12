import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Method to check and get the current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Define platform-specific settings
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, // Use high accuracy for location
      distanceFilter: 10, // Minimum distance (in meters) before an update
    );

    // Get the current location using the updated settings
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  // Method to get address from latitude and longitude (in Thai)
  Future<List<Placemark>> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks;
      }
      return [];
    } catch (e) {
      throw Exception("ไม่สามารถดึงที่อยู่ได้: $e");
    }
  }
}
