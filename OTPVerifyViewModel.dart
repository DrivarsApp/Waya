import 'package:flutter/cupertino.dart';
import 'package:gogame/constants/API.dart';
import 'package:gogame/constants/languageContstants.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/services/api_service.dart';
import 'package:gogame/ui/shared/shared_preference.dart';
import 'package:gogame/utils.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OTPVerifyViewModel extends BaseModel {
  Map<String, dynamic> userData = new Map();

  String type;

  checkLoginDetails(String mobileNo) {
    Map<String, dynamic> loginData = {
      'mobileno': mobileNo,
    };
    loginUser(loginData);
  }

  OTPVerifyViewModel(BuildContext newContext) {
    context = newContext;
  }

  void loginUser(Map<String, dynamic> loginData) {
    Utility.isInternetAvailable().then((isConnected) async {
      if (isConnected) {
        setState(ViewState.Busy);
        ApiService.postRequest(
            url: API.loginUser,
            params: loginData,
            header: false,
            onSuccess: (Map data) async {
              setState(ViewState.Idle);
              type = data['type'];
            },
            onError: (String message, Map<String, dynamic> response) {
              showMessageInFlushBar(message, true);

              setState(ViewState.Idle);
            });
      } else {
        showMessageInFlushBar(translate(no_internet_connection), true);
        setState(ViewState.Idle);
      }
    });
  }

  void verifyOTP(String otp, String mobileNo) {
    Map<String, dynamic> loginData = {
      'mobileno': mobileNo,
      'otp': otp,
      'userType': type
    };
    setState(ViewState.Busy);
    Utility.isInternetAvailable().then((isConnected) async {
      if (isConnected) {
        setState(ViewState.Busy);
        ApiService.postRequest(
            url: API.checkOTP,
            header: false,
            params: loginData,
            onSuccess: (Map data) async {
              setState(ViewState.Idle);
              String userName = data['username'];
              String UserId = data['data']['UserId'];
              String AccessToken = data['data']['AccessToken'];
              UserPreference.saveUserDetails(
                  userName, UserId, AccessToken, mobileNo);
              if (userName == null || userName.isEmpty) {
                redirectToPage(UsernameViewRoute, arguments: {
                  'mobile': mobileNo,
                  'userId': UserId,
                  'accessToken': AccessToken
                });
              } else {
                UserPreference.setUserLogin(true);
                redirectWithClearBackStack(DashboardViewRoute);
              }
            },
            onError: (String message, Map<String, dynamic> response) {
              showMessageInFlushBar(message, true);

              setState(ViewState.Idle);
            });
      } else {
        showMessageInFlushBar(translate(no_internet_connection), true);
        setState(ViewState.Idle);
      }
    });
  }
}
