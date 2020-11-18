import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/ui/views/DataRecharge/DataRechargeViewModel.dart';
import 'package:gogame/ui/views/Profile/ProfileViewModel.dart';
import 'package:gogame/ui/views/dashboard/DashboardViewModel.dart';
import 'package:gogame/ui/widgets/TextInputField.dart';
import 'package:gogame/ui/widgets/custom_button.dart';
import 'package:gogame/ui/widgets/textfieldcustom.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with BaseCommonWidget, TickerProviderStateMixin {
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    _contactController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      onModelReady: (model) {},
      viewModel: ProfileViewModel(context),
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

  Widget _getBody(ProfileViewModel model) {
    return Stack(
      children: <Widget>[
        //Actual widget data
        _getBaseContainer(model),
        //Progress loader
        getProgressBar(model.state),
      ],
    );
  }

  Widget _getBaseContainer(ProfileViewModel model) {
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
                  SizeConfig.verticalSpacer(3.0),
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: SizeConfig.relativeWidth(25.0),
                              height: SizeConfig.relativeWidth(25.0),
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            width: SizeConfig.relativeWidth(25.0),
                            height: SizeConfig.relativeWidth(25.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: AppColors.white,
                            ),
                          ),
                  ),
                  SizeConfig.verticalSpacer(3.0),
                  Container(
                    width: SizeConfig.relativeWidth(30.0),
                    height: SizeConfig.relativeHeight(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: AppColors.orangeDark,
                    ),
                    child: Center(
                      child: Text(
                        "KYC : Pending",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppTheme.interRegular,
                          fontStyle: FontStyle.normal,
                          fontSize: SizeConfig.setSp(12.0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    textController: _nameController,
                    labelText: 'Name',
                    showHelperText: false,
                    showSuffix: true,
                  ),
                  SizeConfig.verticalSpacer(3.0),
                  TextFieldCustom(
                    textController: _emailController,
                    labelText: 'Email',
                    showHelperText: false,
                    showSuffix: true,
                  ),
                  SizeConfig.verticalSpacer(3.0),
                  TextFieldCustom(
                    textController: _contactController,
                    labelText: 'Contact',
                    showHelperText: false,
                    showSuffix: true,
                  ),
                  SizeConfig.verticalSpacer(10.0),
                  CustomButton(
                    buttonText: "UPDATE",
                    onTapped: () {},
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
