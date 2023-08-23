import 'package:get/get.dart';
import 'package:house_scout/models/house_owner_prop.dart';
import 'package:house_scout/models/user_details_response.dart';
import 'package:house_scout/services/remote_services.dart';

class PropertyViewController extends GetxController {
  var userDetails;
  var count = 1.obs;

  Future<UserDetailsResponse?> userDetailsRes() async {
    UserDetailsResponse? user = await RemoteServices.userDetails();
    if (user != null) {
      return user;
    }
    return null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userDetailsRes();
  }
}
