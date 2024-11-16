import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sle_seller/Package/PackageConstants.dart';

class ConnectivityHelper {
  static Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    printDebug('>>>$connectivityResult');
    printDebug('>>>^${connectivityResult.contains(ConnectivityResult.none)}');
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
