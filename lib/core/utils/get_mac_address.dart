import 'package:network_info_plus/network_info_plus.dart';

Future<String?> getMacAddress() async {
  final NetworkInfo networkInfo = NetworkInfo();
  String? macAddress;

  try {
    macAddress = await networkInfo
        .getWifiBSSID(); // BSSID is often the MAC address of the access point
    print('MAC address:==>> $macAddress');

  } catch (e) {
    print('Failed to get MAC address: $e');
  }

  return macAddress;
}
