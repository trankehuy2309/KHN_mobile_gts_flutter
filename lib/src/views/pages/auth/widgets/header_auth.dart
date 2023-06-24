// This widget will draw header section of all page. Wich you will get with the project source code.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khn_tracking/src/core/controllers/app_system_controller.dart';

class HeaderAuth extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final bool _language;
  final IconData _icon;

  const HeaderAuth(this._height, this._showIcon, this._language, this._icon,
      {Key? key})
      : super(key: key);

  @override
  _HeaderAuthState createState() =>
      // ignore: no_logic_in_create_state
      _HeaderAuthState(_height, _showIcon, _language, _icon);
}

class _HeaderAuthState extends State<HeaderAuth> {
  final double _height;
  final bool _showIcon;
  final bool _language;
  final IconData _icon;

  _HeaderAuthState(this._height, this._showIcon, this._language, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    // ignore: deprecated_member_use
                    Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 5, _height),
            Offset(width / 10 * 5, _height - 60),
            Offset(width / 5 * 4, _height + 20),
            Offset(width, _height - 18)
          ]),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    // ignore: deprecated_member_use
                    Theme.of(context).accentColor.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 3, _height + 20),
            Offset(width / 10 * 8, _height - 60),
            Offset(width / 5 * 4, _height - 60),
            Offset(width, _height - 20)
          ]),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    // ignore: deprecated_member_use
                    Theme.of(context).accentColor,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 5, _height),
            Offset(width / 2, _height - 40),
            Offset(width / 5 * 4, _height - 80),
            Offset(width, _height - 20)
          ]),
        ),
        SizedBox(
          height: _height,
          child: Center(
            child: Image.asset('assets/images/logo_khn.png', width: 120),
          ),
        ),
        _language
            ? Obx(() {
                return Positioned(
                    right: 20,
                    top: 30,
                    child: TextButton.icon(
                        onPressed: () {
                          Get.find<AppSystemController>().changeLocale();
                        },
                        icon: const Icon(Icons.language, color: Colors.white),
                        label: Text(
                            Get.find<AppSystemController>().mLanguage == 'vi'
                                ? 'Tiếng Việt'
                                : 'English',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))));
              })
            : const Text(''),
      ],
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
