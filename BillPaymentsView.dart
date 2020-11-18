import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/BillPayments/BillPaymentsViewModel.dart';
import 'package:gogame/ui/views/DataRecharge/DataRechargeViewModel.dart';
import 'package:gogame/ui/views/dashboard/DashboardViewModel.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class BillPaymentsView extends StatefulWidget {
  @override
  _BillPaymentsViewState createState() => _BillPaymentsViewState();
}

class _BillPaymentsViewState extends State<BillPaymentsView>
    with BaseCommonWidget, TickerProviderStateMixin {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BillPaymentsViewModel>.withConsumer(
      onModelReady: (model) {},
      viewModel: BillPaymentsViewModel(context),
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

  Widget _getBody(BillPaymentsViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  Widget _getBaseContainer(BillPaymentsViewModel model) {
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
                  SizeConfig.verticalSpacer(1.0),
                  _advertisementCarousel(),
                  SizeConfig.verticalSpacer(5.0),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.relativeHeight(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.televisionClassic,
                              color: AppColors.blackDark,
                              size: SizeConfig.relativeSize(30.0),
                            ),
                            // Cable TV
                            Text(
                              "Cable TV ",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: AppTheme.interBold,
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.setSp(12.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.lightningBoltOutline,
                              color: AppColors.blackDark,
                              size: SizeConfig.relativeSize(30.0),
                            ),
                            // Cable TV
                            Text(
                              "Electricity",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: AppTheme.interBold,
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.setSp(12.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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

  Widget _advertisementCarousel() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: SizeConfig.relativeHeight(20.0),
        child: Row(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.relativeWidth(5.0),
                      vertical: SizeConfig.relativeHeight(2.0),
                    ),
                    height: SizeConfig.relativeHeight(20.0),
                    width: SizeConfig.relativeWidth(78.0),
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Advertisement",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700,
                            fontFamily: AppTheme.interBold,
                            fontStyle: FontStyle.normal,
                            fontSize: SizeConfig.setSp(17.0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          ImagesPaths.iconWaya,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizeConfig.horizontalSpacer(4.0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
