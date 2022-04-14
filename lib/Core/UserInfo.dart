import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String svgIcon;
  final Function press;
  final Widget attachments;

  const MenuItem({
    Key key,
    this.icon,
    this.svgIcon,
    this.title,
    this.press,
    this.attachments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 26,
        ),
        child: Row(
          children: [
            svgIcon == null
                ? Icon(icon)
                : SvgPicture.asset(
                    svgIcon,
                    color: Color(0xff292121),
                    height: 20,
                    width: 20,
                    allowDrawingOutsideViewBox: true,
                  ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 17 * MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212529),
              ),
            ),
            Spacer(),
            attachments == null ? Container() : attachments,
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool setUpStage = true;
  int remains = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 26,
                ),
                child: Row(children: [
                  Text(
                    "User",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ]),
              ),
              MenuItem(
                title: "Logout",
                icon: Icons.logout,
                press: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
