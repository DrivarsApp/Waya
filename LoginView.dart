import 'package:flutter/material.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/user/login/LoginViewModel.dart';
import 'package:gogame/ui/widgets/custom_button.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import '../../../shared/size_config.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseCommonWidget {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isChecked = false;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _mobileController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(context),
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

  Widget _getBody(LoginViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  _getBaseContainer(LoginViewModel model) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImagesPaths.iconWaya,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Opacity(
              opacity: 0.85,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.purpleColor.withOpacity(0.99),
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: AppColors.purpleColor.withOpacity(0.59),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(8.88),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeConfig.verticalSpacer(10.0),
                  Text(
                    " Login Here",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppTheme.interBold,
                      fontStyle: FontStyle.normal,
                      fontSize: SizeConfig.setSp(24.0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizeConfig.verticalSpacer(5.0),
                  _textInput(
                    textInputController: _mobileController,
                    hintText: " Mobile Number / Email",
                    obscureText: false,
                  ),
                  SizeConfig.verticalSpacer(5.0),
                  _textInput(
                    textInputController: _passwordController,
                    hintText: " Password",
                    obscureText: true,
                  ),
                  SizeConfig.verticalSpacer(2.0),
                  InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: AppColors.whiteLight,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppTheme.interRegular,
                          fontStyle: FontStyle.normal,
                          fontSize: SizeConfig.setSp(16.0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpacer(3.0),
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: AppColors.white,
                    ),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "I agree with Terms and Conditions",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppTheme.interRegular,
                          fontStyle: FontStyle.normal,
                          fontSize: SizeConfig.setSp(14.0),
                        ),
                      ),
                      value: _isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          _isChecked = value;
                        });
                      },
                      activeColor: AppColors.whiteLight,
                      checkColor: AppColors.blackDark,
                      dense: true,
                    ),
                  ),
                  SizeConfig.verticalSpacer(5.0),
                  CustomButton(
                    buttonText: "Submit",
                    onTapped: () => model.redirectToPage(DashboardViewRoute),
                  ),
                  SizeConfig.verticalSpacer(5.0),
                  InkWell(
                    onTap: () {
                      model.redirectToPage(CreateAccountViewRoute);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppTheme.interRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeConfig.setSp(14.0),
                                ),
                                text: "Don\'t have an account yet ? "),
                            TextSpan(
                              style: TextStyle(
                                color: AppColors.orangeDark,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppTheme.interRegular,
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.setSp(14.0),
                              ),
                              text: "Create Now",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textInput(
      {TextEditingController textInputController,
      String hintText,
      bool obscureText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            color: AppColors.whiteLight,
            fontWeight: FontWeight.w400,
            fontFamily: AppTheme.interRegular,
            fontStyle: FontStyle.normal,
            fontSize: SizeConfig.setSp(18.0),
          ),
          textAlign: TextAlign.center,
        ),
        SizeConfig.verticalSpacer(1.5),
        TextField(
          controller: textInputController,
          autofocus: false,
          obscureText: obscureText,
          style: TextStyle(
            fontFamily: AppTheme.interRegular,
            fontSize: SizeConfig.setSp(18.0),
            color: AppColors.blackDark,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: SizeConfig.relativeWidth(4),
              bottom: SizeConfig.relativeHeight(1.20),
              top: SizeConfig.relativeHeight(1.20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}
