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
