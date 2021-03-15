import 'package:ecommerce/screens/farmer_screen.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  final bool isOutlined;
  final Function onClick;
  final double fixedWidth;
  final bool buttonSize;
  final IconData iconn;
  final Color bgColor;
  final String hintText;
  final Function onPressed2;
  const GoogleSignupButtonWidget(
      {this.hintText,
      this.onPressed2,
      this.bgColor,
      this.isOutlined,
      this.buttonSize,
      this.iconn,
      this.fixedWidth, this.onClick});
  @override
  Widget build(BuildContext context) {
    Icon icon2 = Icon(iconn);
    return Container(
      padding: EdgeInsets.all(4),
      child: Container(
        width: fixedWidth,
        child: RaisedButton.icon(
          label: Text(
            hintText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize:14  ),
          ),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: bgColor ?? Colors.red[100],
          textColor: Colors.black,
          splashColor: Colors.greenAccent,
          icon: icon2,
          onPressed: onClick,
        ),
      ),
    );
  }
}
