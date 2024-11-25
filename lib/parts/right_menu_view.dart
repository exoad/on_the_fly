import 'package:auto_img/parts/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RightMenuView extends StatelessWidget {
  const RightMenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          WindowTitleBarBox(
            child: SizedBox(child: Row(children: <Widget>[
              Expanded(child: MoveWindow()),
              const AppWindowTitleButtons()
            ]))
          ),
          AppBar(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: 250,
                    height: 200,
                    child: SvgPicture.asset(
                        "assets/illust/undraw_loading.svg",
                        height: 200)),
                const SizedBox(height: 18),
                const Text("Nothing to do right now..."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
