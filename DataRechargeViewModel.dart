import 'package:flutter/material.dart';
import 'package:gogame/viewmodels/base_model.dart';

class DataRechargeViewModel extends BaseModel {
  bool tabSelected = true;

  DataRechargeViewModel(BuildContext newContext) {
    context = newContext;
  }

  void menuSelected(bool val) {
    tabSelected = val;
    notifyListeners();
  }
}
