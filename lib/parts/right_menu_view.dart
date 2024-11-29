import 'package:on_the_fly/parts/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_the_fly/parts/events/job_stack.dart';
import 'package:provider/provider.dart';

class AppRightMenuView extends StatelessWidget {
  const AppRightMenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          WindowTitleBarBox(
              child: SizedBox(
                  child: Row(children: <Widget>[
            Expanded(child: MoveWindow()),
            const AppWindowTitleButtons()
          ]))),
          if (Provider.of<GlobalJobStack>(context).jobStack.isEmpty)
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
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: Provider.of<GlobalJobStack>(context).jobStack.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(Provider.of<GlobalJobStack>(context)
                        .jobStack[index]
                        .toString()),
                    onTap: () {
                      Provider.of<GlobalJobStack>(context, listen: false)
                          .removeJob(Provider.of<GlobalJobStack>(context)
                              .jobStack[index]);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
