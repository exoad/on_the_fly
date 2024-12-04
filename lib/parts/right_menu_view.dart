import 'package:on_the_fly/parts/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_the_fly/parts/events/job_stack.dart';
import 'package:on_the_fly/shared/theme.dart';
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
            Expanded(
                child: Stack(
                    children: <Widget>[const AppTopShelf(), MoveWindow()])),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRRArc),
                    border: Border.all(color: kThemePrimaryFg2)),
                child: const AppWindowTitleButtons())
          ]))),
          const SizedBox(height: 16),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemCount:
                      Provider.of<GlobalJobStack>(context).jobStack.length,
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
            ),
        ],
      ),
    );
  }
}

class AppTopShelf extends StatelessWidget {
  const AppTopShelf({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: double.infinity,
              decoration: BoxDecoration(
                // border: Border.all(color: kThemePrimaryFg2),
                borderRadius: BorderRadius.circular(kRRArc),
                /*gradient: const LinearGradient(
                      colors: <Color>[kTheme2, kTheme1],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight)*/
              ),
              child: Text(
                  "Jobs: ${Provider.of<GlobalJobStack>(context).jobStack.length}",
                  style: const TextStyle(
                      fontFamily: kStylizedFontFamily,
                      fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
        ]));
  }
}
