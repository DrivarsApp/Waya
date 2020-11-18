import 'package:flutter/material.dart';
import 'package:gogame/viewmodels/base_model.dart';

class GiftViewModel extends BaseModel {
  bool tabSelected = true;
  GiftViewModel(BuildContext newContext) {
    context = newContext;
  }

  void menuSelected(bool val) {
    tabSelected = val;
    notifyListeners();
  }
}
