import 'package:flutter/material.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/user/otp/OTPVerifyViewModel.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import '../../../shared/size_config.dart';

class OTPVerifyView extends StatefulWidget {
  @override
  _OTPVerifyViewState createState() => _OTPVerifyViewState();
}

class _OTPVerifyViewState extends State<OTPVerifyView> with BaseCommonWidget {
  TextEditingController mobileController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<OTPVerifyViewModel>.withConsumer(
      viewModel: OTPVerifyViewModel(context),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                SizeConfig().init(ctx, constraints);
                return _getBody(model);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _getBody(OTPVerifyViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  _getBaseContainer(OTPVerifyViewModel model) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }

  _getTextContainer(OTPVerifyViewModel model) {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.relativeWidth(4.85),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello',
            //textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: SizeConfig.setSp(30),
              fontFamily: AppTheme.interRegular,
            ),
          ),
          Text(
            'Gamer',
            style: TextStyle(
              fontSize: SizeConfig.setSp(30),
              fontFamily: AppTheme.interBold,
            ),
          )
        ],
      ),
    );
  }

  void verify(String OTP, OTPVerifyViewModel model) {
    if (OTP.length == 6) {
      model.verifyOTP(OTP, mobileController.text.trim());
      model.redirectToPage(UsernameViewRoute);
    }
  }
}
