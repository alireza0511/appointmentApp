
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


enum LocationMode { Current, Selected, NotUser, Default }

class LocationStruct {
  final double latitude;
  final double longitude;
  final String address;
  final LocationMode mode;

  const LocationStruct(
      {@required this.latitude,
      @required this.longitude,
      this.address,
      this.mode});

  static Future<LocationStruct> getJustCurrentLocation(BuildContext ctx) async {
    final locData = await Location().getLocation();

    if (locData == null) {
      return null;
    }

    final loc = LocationStruct(
      latitude: locData.latitude,
      longitude: locData.longitude,
      mode: LocationMode.Current,
    );

    return loc;
  }

  static Future<LocationStruct> getCurrentUserLocation(BuildContext ctx) async {
    final locData = await Location().getLocation();

    if (locData == null) {
      return null;
    }

    final List<Placemark> placeMark = await Geolocator()
        .placemarkFromCoordinates(locData.latitude, locData.longitude);
    if (placeMark.length >= 1) {
      var address = placeMark[0].subThoroughfare +
          ' ' +
          placeMark[0].thoroughfare +
          ', ' +
          placeMark[0].subLocality +
          ' ' +
          placeMark[0].locality +
          ', ' +
          placeMark[0].administrativeArea +
          ', ' +
          placeMark[0].isoCountryCode +
          ', ' +
          placeMark[0].postalCode;

      final loc = LocationStruct(
          latitude: locData.latitude,
          longitude: locData.longitude,
          mode: LocationMode.Current,
          address: address);

      return loc;
    } else {
      final loc = LocationStruct(
        latitude: locData.latitude,
        longitude: locData.longitude,
        mode: LocationMode.Current,
      );

      return loc;
    }
  }

  static Future<LocationStruct> getLocationFromAddress(String address) async {
    final List<Placemark> placeMark =
        await Geolocator().placemarkFromAddress(address);
    var placeMarkAddress = placeMark[0].subThoroughfare +
        ' ' +
        placeMark[0].thoroughfare +
        ' ' +
        placeMark[0].subLocality +
        ', ' +
        placeMark[0].locality +
        ', ' +
        placeMark[0].administrativeArea +
        ', ' +
        placeMark[0].isoCountryCode +
        ', ' +
        placeMark[0].postalCode;
    var loc = LocationStruct(
        latitude: placeMark[0].position.latitude,
        longitude: placeMark[0].position.longitude,
        address: placeMarkAddress);

    return loc;
  }

  static double convertDistanceToMile(double dist) {
    double distMile = (dist * 10 / 1609.344).round() / 10;
    return distMile;
  }

  
  static const String k1 = 'AIzaSyAJx';
  static const String k2 = 'Twq8Bde9y';
  static const String k3 = '_';
  static const String k4 = '1G0ETOoxr';
  static const String k5 = 'mzJleBA9dx8';
}

