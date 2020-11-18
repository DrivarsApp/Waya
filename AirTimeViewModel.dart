import 'package:flutter/material.dart';
import 'package:gogame/viewmodels/base_model.dart';

class AirTimeViewModel extends BaseModel {
  bool tabSelected = true;
  AirTimeViewModel(BuildContext newContext) {
    context = newContext;
  }

  void menuSelected(bool val) {
    tabSelected = val;
    notifyListeners();
  }
}
