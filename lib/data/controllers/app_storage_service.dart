import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/models/user_data_model.dart';

class AppStorageController extends GetxService {
  static AppStorageController to = Get.isRegistered<AppStorageController>() ? Get.find<AppStorageController>() : Get.put(AppStorageController());
  final userDataBox = GetStorage();
  final userDataKey = "userDataKey";
  final isuserLoggedInKey = "isuserLoggedInKey";
  UserDataModel? currentUser;

  @override
  void onInit() {
    asyncCurrentUser.then((value) {
      currentUser = value;
    });
    super.onInit();
  }

  Future<void> saveUserData(Map<String, dynamic> data) async {
    await userDataBox.write(userDataKey, data);
    currentUser = UserDataModel.fromJson(data);
  }

  Future<void> login(Map<String, dynamic> data) async {
    await saveUserData(data);
    await userDataBox.write(isuserLoggedInKey, true);
    currentUser = UserDataModel.fromJson(data);
    Get.offAllNamed(Routes.DASHBOARD_PAGE);
  }

  Future<bool> isUserLoggedIn() async {
    return await userDataBox.read(isuserLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    await userDataBox.remove(userDataKey);
    await userDataBox.remove(isuserLoggedInKey);
    await GetStorage().erase();
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  Future<UserDataModel?> get asyncCurrentUser async {
    var data = await userDataBox.read(userDataKey) as Map<String, dynamic>?;
    if (data != null) {
      return UserDataModel.fromJson(data);
    } else {
      return null;
    }
  }
}
