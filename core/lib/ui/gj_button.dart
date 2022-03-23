import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:core/color/app_color.dart';
import 'package:core/const/app_const.dart';
import 'package:core/fonts/font_utils.dart';

// ignore: must_be_immutable
class GjButton extends StatelessWidget {
  String text;
  VoidCallback? press;
  bool isActive = true;
  bool isLoading = false;
  double heightButton = -1;
  double widthButton = -1;
  String? icon = '';
  TextStyle? styleText;
  BoxBorder? border;
  Color colorBackgroundButton;
  TextStyle defaultStyle = FontUtils.getAppFont(
      fontSize: 16, textColor: AppColor.white, fontWeight: FontWeight.w700);

  //////////
  double radiusButton = 10;
  double fontSize = 20;
  Color loadingColor = AppColor.grey100;
  double sizeLoading = 30.0;

  GjButton(
      {Key? key,
      required this.text,
      this.isActive = true,
      this.isLoading = false,
      this.heightButton = -1,
      this.widthButton = -1,
      this.press,
      this.colorBackgroundButton = AppColor.primary,
      this.styleText,
      this.icon,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildButtonLoading();
    } else {
      if (isActive) {
        return _buildButtonActive();
      } else {
        return _buildButtonNotActive();
      }
    }
  }

  Widget _buildButtonActive() {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: heightButton == -1 ? AppConst.kHeightButton : heightButton,
        width: widthButton == -1 ? double.infinity : widthButton,
        decoration: BoxDecoration(
            // ignore: prefer_if_null_operators
            border: border != null ? border : null,
            // color: border == null ? colorBackgroundButton : Colors.white,
            color: colorBackgroundButton,
            borderRadius: BorderRadius.all(Radius.circular(radiusButton))),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(radiusButton)),
          onTap: press,
          child: icon != ''
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icon ?? ''),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      // ignore: prefer_if_null_operators
                      style: styleText != null ? styleText : defaultStyle,
                    )
                  ],
                )
              : Text(
                  text,
                  // ignore: prefer_if_null_operators
                  style: styleText != null ? styleText : defaultStyle,
                ), // other widget
        ),
      ),
    );
  }

  Widget _buildButtonLoading() {
    return Container(
      alignment: Alignment.center,
      height: heightButton == -1 ? AppConst.kHeightButton : heightButton,
      width: widthButton == -1 ? double.infinity : widthButton,
      decoration: BoxDecoration(
          color: colorBackgroundButton,
          borderRadius: BorderRadius.all(Radius.circular(radiusButton))),
      child: SpinKitRing(
        color: loadingColor,
        size: sizeLoading,
        lineWidth: 3,
      ),
    );
  }

  Widget _buildButtonNotActive() {
    return Container(
      alignment: Alignment.center,
      height: heightButton == -1 ? AppConst.kHeightButton : heightButton,
      width: widthButton == -1 ? double.infinity : widthButton,
      decoration: BoxDecoration(
          // ignore: prefer_if_null_operators
          border: border != null ? border : null,
          color: border == null ? AppColor.colorButtonDisable : AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(radiusButton))),
      child: icon != ''
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon ?? ''),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  // ignore: prefer_if_null_operators
                  style: styleText != null ? styleText : defaultStyle,
                )
              ],
            )
          : Text(
              text,
              // ignore: prefer_if_null_operators
              style: styleText != null ? styleText : defaultStyle,
            ),
    );
  }
}
