import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogame/constants/images.dart';
import 'package:gogame/constants/route_names.dart';
import 'package:gogame/ui/shared/app_colors.dart';
import 'package:gogame/ui/shared/app_theme.dart';
import 'package:gogame/ui/shared/size_config.dart';
import 'package:gogame/ui/views/BaseCommonWidget.dart';
import 'package:gogame/viewmodels/base_model.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/languageContstants.dart';
import '../../../shared/size_config.dart';
import 'UsernameViewModel.dart';

class UsernameView extends StatefulWidget {
  final Map<String, dynamic> params;
  @override
  _UsernameViewState createState() => _UsernameViewState();

  UsernameView({this.params});
}

class _UsernameViewState extends State<UsernameView> with BaseCommonWidget {
  TextEditingController usernameController = new TextEditingController();


  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<UsernameViewModel>.withConsumer(
      viewModel: UsernameViewModel(context),
      onModelReady: (model) => model.setUserData(widget.params),
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

  Widget _getBody(UsernameViewModel model) {
    return Stack(
      children: <Widget>[
        _getBaseContainer(model),
        getProgressBar(model.state),
      ],
    );
  }

  _getBaseContainer(UsernameViewModel model) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }


}
