import 'package:flutter/material.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Services/Api/Auth/Auth_Services.dart';
import 'package:main_store/Services/Dialog/Dialog_Services.dart';
import 'package:main_store/Services/Navigation/navigation_services.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';
import 'package:main_store/View/Home/Views/home_desktop.dart';

class AccountVerificationViewModel extends ChangeNotifier {
  Navigation _navigation = locator<Navigation>();
  DialogService _alertDialog = locator<DialogService>();
  AuthServicesApi _authServicesApi = locator<AuthServicesApi>();
  StorageServices _services = locator<StorageServices>();
  TextEditingController controller = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  bool isLoading = false;
  String pin = "";

  setBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  checkCode() async {
    var code = await _services.getCode();
    int userId = await _services.getUserId();
    setBusy(true);
    if (code == pin) {
      _authServicesApi.verifyAccount(userId);
      _navigation.pushReplaceRoute(Home());
    } else {
      _alertDialog.showDialog(
          title: 'Pin Code Error',
          description: 'Pin Code is Incorrect',
          buttonTitle: "Close");
    }
    setBusy(false);
  }
}
