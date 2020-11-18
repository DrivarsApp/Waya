import 'package:flutter/cupertino.dart';
import 'package:gogame/constants/API.dart';
import 'package:gogame/constants/languageContstants.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/services/api_service.dart';
import 'package:gogame/ui/shared/shared_preference.dart';
import 'package:gogame/utils.dart';
import 'package:gogame/viewmodels/base_model.dart';

class UsernameViewModel extends BaseModel {
  String userID, accessId, mobileNo;
  List<dynamic> suggestions = [];

  UsernameViewModel(BuildContext newContext) {
    context = newContext;
  }

  void checkUsername(String username) async {
    Map<String, dynamic> params = {
      'username': username,
    };
    setState(ViewState.Busy);
    Utility.isInternetAvailable().then((isConnected) async {
      if (isConnected) {
        setState(ViewState.Busy);
        ApiService.postRequest(
            header: false,
            url: API.checkUser,
            params: params,
            onSuccess: (Map data) async {
              setState(ViewState.Idle);
              registerUser(username);
            },
            onError: (String message, Map<String, dynamic> response) {
              showMessageInFlushBar(message, true);
              setState(ViewState.Idle);
              if (response.containsKey('data')) {
                print('suggestions list => ${response['data']}');

                suggestions = response['data'];
                print('suggestions list => $suggestions');
              }
            });
      } else {
        showMessageInFlushBar(translate(no_internet_connection), true);
        setState(ViewState.Idle);
      }
    });
  }

  void registerUser(String username) async {
    Map<String, dynamic> params = {'username': username, 'UserId': userID};
    print('add usernmae ==> $params');
    ApiService.postRequest(
        header: true,
        url: API.addUsername,
        params: params,
        onSuccess: (Map data) async {
          setState(ViewState.Idle);
          UserPreference.setUsername(username);
          UserPreference.setUserLogin(true);
          redirectWithClearBackStack(DashboardViewRoute);
        },
        onError: (String message, Map<String, dynamic> response) {
          showMessageInFlushBar(message, true);
          setState(ViewState.Idle);
        });
  }

  setUserData(Map<String, dynamic> params) async {
    mobileNo = params['mobile'] as String;
    userID = params['userId'] as String;
    accessId = params['accessToken'] as String;
    print('Userid===> $userID');
  }
}
