import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

import '../../../core/exports.dart';
import 'state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    checkAndRequestLocationPermission();
  }
  loc.LocationData? currentLocation;
  Future<void> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied) {
      PermissionStatus newPermissionStatus =
          await Permission.location.request();
      if (newPermissionStatus.isGranted) {
        await enableLocationServices();
      } else if (newPermissionStatus.isDenied) {}
    } else if (permissionStatus.isGranted) {
      await enableLocationServices();
    }
  }

  Future<void> enableLocationServices() async {
    loc.Location location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      } else {
        getCurrentLocation();
      }
    }
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {
      getCurrentLocation();
    } else {}
  }

  Future<void> getCurrentLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
      (location) async {
        currentLocation = location;
        // emit(GetCurrentLocationState());
        debugPrint("lat: ${currentLocation?.latitude}");
        debugPrint("long: ${currentLocation?.longitude}");
      },
    );
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      debugPrint(currentLocation.toString());
    });
  }
}
