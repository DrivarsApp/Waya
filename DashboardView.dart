import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/BillPayments/BillPaymentsView.dart';
import 'package:gogame/ui/views/dashboard/DashboardViewModel.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
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
    return ViewModelProvider<DashboardViewModel>.withConsumer(
      onModelReady: (model) {},
      viewModel: DashboardViewModel(context),
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

  Widget _getBody(DashboardViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  Widget _getBaseContainer(DashboardViewModel model) {
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
                icon: InkWell(
                  onTap: () {
                    model.redirectToPage(ProfileViewRoute);
                  },
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: SizeConfig.relativeSize(15.0),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.phoneDialOutline,
                          menuTitle: "Airtime",
                          onTapped: () {
                            model.redirectToPage(AirTimeViewRoute);
                          }),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.cellphoneWireless,
                          menuTitle: "Data",
                          onTapped: () {
                            model.redirectToPage(DataRechargeViewRoute);
                          }),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.clipboardTextMultipleOutline,
                          menuTitle: "Pay Bills",
                          onTapped: () {
                            model.redirectToPage(BillPaymentsViewRoute);
                          }),
                    ],
                  ),
                  SizeConfig.verticalSpacer(2.0),
                  _carouselItemList(),
                  SizeConfig.verticalSpacer(2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.contactlessPaymentCircleOutline,
                          menuTitle: "Pay Now",
                          onTapped: () {}),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.transfer,
                          menuTitle: "Recieve",
                          onTapped: () {}),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.walletOutline,
                          menuTitle: "Wallet",
                          onTapped: () {}),
                    ],
                  ),
                  SizeConfig.verticalSpacer(2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.chatOutline,
                          menuTitle: "Chat",
                          onTapped: () {}),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.giftOutline,
                          menuTitle: "Gift Card",
                          onTapped: () {}),
                      _dashboardMenuItems(
                          menuIcon: MdiIcons.tagHeartOutline,
                          menuTitle: "Offers",
                          onTapped: () {}),
                    ],
                  ),
                  SizeConfig.verticalSpacer(2.0),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.relativeHeight(25.46),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.relativeWidth(5.0),
                      vertical: SizeConfig.relativeHeight(5.0),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Refer Waya to Friends ",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                                fontFamily: AppTheme.interBold,
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.setSp(15.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Get Reward",
                              style: TextStyle(
                                color: AppColors.blackDark,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppTheme.interBold,
                                fontStyle: FontStyle.normal,
                                fontSize: SizeConfig.setSp(20.0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Image.asset(
                          ImagesPaths.iconWaya,
                        ),
                      ],
                    ),
                  ),
                  SizeConfig.verticalSpacer(3.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dashboardMenuItems(
      {IconData menuIcon, String menuTitle, Function onTapped}) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        width: SizeConfig.relativeWidth(28.00),
        height: SizeConfig.relativeHeight(15.99),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(menuIcon,
                size: SizeConfig.relativeSize(20.0), color: Colors.purple[800]),
            SizeConfig.verticalSpacer(1.0),
            Text(
              menuTitle,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
                fontFamily: AppTheme.interBold,
                fontStyle: FontStyle.normal,
                fontSize: SizeConfig.setSp(14.0),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _carouselItemList() {
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
                          "Instant\nRecharge",
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
