import 'dart:async';
import 'dart:ffi';

import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_scout/models/house_owner_prop.dart';
import 'package:house_scout/services/remote_services.dart';
import 'package:geolocator/geolocator.dart';

class DashboardController extends GetxController {
  RxBool favIcon = false.obs;
  var icon = const Icon(
    Icons.favorite_border,
    color: Colors.red,
    size: 30,
  ).obs;

  List properties = [].obs;
  StreamSubscription<GeofenceStatus>? geofenceStreamingStatus;
  String geofenceStatus = '';

  Position? position;
  bool isReady = false;
  var distance = 0.0.obs;

  getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    isReady = position != null ? true : false;
  }

  getDistance(String? latitude, String? longitude) async {
    await getCurrentPosition();

    var poLat = double.parse(latitude.toString());
    var poLon = double.parse(longitude.toString());

    distance.value = Geolocator.distanceBetween(
        position!.latitude, position!.longitude, poLat, poLon);
  }

  propertiesList() async {
    List<HouseOwnerProperty>? props =
        await RemoteServices.houseOwnerProperties();
    if (props!.isNotEmpty) {
      for (var element in props) {
        if (element.latitude!.contains("null")) {
        } else {
          double poLat = double.parse(element.latitude.toString());
          double poLon = double.parse(element.longitude.toString());

          print(poLat);
          print(poLon);

          await getDistance(element.latitude, element.longitude);

          print("distance: $distance");

          if (distance <= 50) {
            properties.add(element);
          }
        }
      }
    }

    print(properties);
  }

  changeFavIcon() {
    favIcon.value = !favIcon.value;
    favIcon.value
        ? icon.value = const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30,
          )
        : icon.value = const Icon(
            Icons.favorite_border,
            color: Colors.red,
            size: 30,
          );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    propertiesList();
  }
}
