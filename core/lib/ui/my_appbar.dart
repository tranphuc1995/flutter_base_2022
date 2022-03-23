import 'package:core/const/app_config.dart';
import 'package:core/fonts/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:core/color/app_color.dart';

import '../const/app_const.dart';

class MyAppBar extends StatelessWidget {
  String title;
  VoidCallback? pressBackButton;
  bool isShowBackButton;
  MyAppBar(
      {Key? key,
      this.title = '',
      this.pressBackButton,
      this.isShowBackButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppConfig.heightStatusBar,
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: AppConst.kStatusBarHeight,
          width: double.infinity,
          color: AppColor.primary,
          child: InkWell(
            onTap: pressBackButton ??
                () {
                  Navigator.pop(context);
                },
            child: Row(children: [
              // Visibility(
              //     visible: isShowBackButton,
              //     child: SvgPicture.asset(Ic.icBack)),
              isShowBackButton
                  ? const SizedBox(
                      width: 16,
                    )
                  : Container(),
              Text(
                title,
                style: FontUtils.getAppFont(
                    fontSize: 20,
                    textColor: AppColor.white,
                    fontWeight: FontWeight.w700),
              )
            ]),
          ),
        )
      ],
    );
  }
}
