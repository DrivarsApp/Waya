import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/AirTime/AirTimeViewModel.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/DataRecharge/DataRechargeViewModel.dart';
import 'package:gogame/ui/views/dashboard/DashboardViewModel.dart';
import 'package:gogame/ui/widgets/TextInputField.dart';
import 'package:gogame/ui/widgets/custom_button.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class AirTimeView extends StatefulWidget {
  @override
  _AirTimeViewState createState() => _AirTimeViewState();
}

class _AirTimeViewState extends State<AirTimeView>
    with BaseCommonWidget, TickerProviderStateMixin {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _plansController = TextEditingController();
  TextEditingController _networkController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumberController?.dispose();
    _plansController?.dispose();
    _networkController?.dispose();
    _amountController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AirTimeViewModel>.withConsumer(
      onModelReady: (model) {},
      viewModel: AirTimeViewModel(context),
      builder: (context, model, child) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              SizeConfig().init(ctx, constraints);
              return _getBody(model);
            },
          ),
        );
      },
    );
  }

  Widget _getBody(AirTimeViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  Widget _getBaseContainer(AirTimeViewModel model) {
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Afternoon',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppTheme.interBold,
                    fontStyle: FontStyle.normal,
                    fontSize: SizeConfig.setSp(12.0),
                  ),
                ),
                Text(
                  'Saket Sharma',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppTheme.interBold,
                    fontStyle: FontStyle.normal,
                    fontSize: SizeConfig.setSp(16.0),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.white,
                  size: SizeConfig.relativeSize(15.0),
                ),
                onPressed: () {},
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.purpleColor.withOpacity(0.15),
            currentIndex: 0, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: SizeConfig.relativeSize(15.0),
                ),
                title: Container(
                  padding: EdgeInsets.zero,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: AppColors.white,
                  size: SizeConfig.relativeSize(15.0),
                ),
                title: Container(
                  padding: EdgeInsets.zero,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MdiIcons.informationVariant,
                  color: AppColors.white,
                  size: SizeConfig.relativeSize(15.0),
                ),
                title: Container(
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.relativeWidth(4.88),
              ),
              child: Column(
                children: [
                  SizeConfig.verticalSpacer(2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RechargeTabs(
                        onTap: () {
                          model.menuSelected(true);
                        },
                        showIndicator: model.tabSelected,
                        title: 'NIGERIA',
                      ),
                      RechargeTabs(
                        onTap: () {
                          model.menuSelected(false);
                        },
                        showIndicator: !model.tabSelected,
                        title: 'INTERNATIONAL',
                      ),
                    ],
                  ),
                  SizeConfig.verticalSpacer(6.0),
                  TextInput(
                    textInputController: _mobileNumberController,
                    hintText: "Mobile Number",
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  SizeConfig.verticalSpacer(1.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        model.redirectToPage(GiftViewRoute);
                      },
                      child: Text(
                        'Gift Airtime ',
                        style: TextStyle(
                          fontSize: SizeConfig.setSp(12.0),
                          fontFamily: AppTheme.interBold,
                          fontStyle: FontStyle.normal,
                          color: AppColors.whiteLight,
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpacer(4.0),
                  TextInput(
                      textInputController: _networkController,
                      hintText: "Select Network Operator",
                      obscureText: false,
                      textInputType: TextInputType.text),
//                  SizeConfig.verticalSpacer(5.0),
//                  TextInput(
//                      textInputController: _plansController,
//                      hintText: "Select Plans",
//                      obscureText: false,
//                      textInputType: TextInputType.text),
                  SizeConfig.verticalSpacer(5.0),
                  TextInput(
                      textInputController: _amountController,
                      hintText: "Amount",
                      obscureText: false,
                      textInputType: TextInputType.number),
                  SizeConfig.verticalSpacer(5.0),
                  CustomButton(
                    onTapped: () {},
                    buttonText: 'Continue',
                  ),
                  SizeConfig.verticalSpacer(5.0),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.relativeHeight(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.whiteLight,
                    ),
                    child: Column(
                      children: [
                        SizeConfig.verticalSpacer(0.5),
                        Text(
                          "Recent Recharge",
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontFamily: AppTheme.interBold,
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.setSp(14.0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(
                          color: AppColors.greyColor,
                        ),
                      ],
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
}

class RechargeTabs extends StatelessWidget {
  RechargeTabs({
    @required this.onTap,
    @required this.showIndicator,
    @required this.title,
  });

  final Function onTap;
  final bool showIndicator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
//      child: Container(
//        height: SizeConfig.relativeHeight(6.43),
//        width: SizeConfig.relativeWidth(44.66),
//        decoration: BoxDecoration(
//          color: showIndicator ? AppColors.blueColor : AppColors.white,
//          border: Border.all(
//            color: AppColors.blueColor,
//            width: 2,
//          ),
//          boxShadow: [
//            BoxShadow(
//              color: AppColors.greyShadow,
//              offset: Offset(0, 0),
//              blurRadius: 6,
//              spreadRadius: 0,
//            )
//          ],
//          borderRadius: BorderRadius.circular(5),
//        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color:
                  showIndicator ? AppColors.orangeDark : AppColors.whiteLight,
              fontFamily: AppTheme.interBold,
              fontSize: SizeConfig.setSp(16.0),
            ),
          ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(
////                    height: SizeConfig.relativeHeight(0.44),
////                    width: SizeConfig.relativeWidth(8.04),
////                    margin: EdgeInsets.only(
////                      right: SizeConfig.relativeWidth(12.5),
////                    ),
//                  height: SizeConfig.relativeHeight(0.43),
//                  width: SizeConfig.relativeWidth(7.66),
//
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(5),
//                    color:
//                        showIndicator ? AppColors.blueColor : AppColors.white,
////                      gradient: LinearGradient(
////                          colors: showIndicator
////                              ? AppColors.blueColor
////                              : [Colors.white, Colors.white]),
//                  ),
//                ),
//              ],
//            ),
        ],
      ),
    );
  }
}
