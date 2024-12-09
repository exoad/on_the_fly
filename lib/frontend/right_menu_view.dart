import 'package:flutter_animate/flutter_animate.dart';
import 'package:on_the_fly/frontend/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';
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
          Container(
            decoration: const BoxDecoration(color: kThemeBg),
            child: SizedBox(
                child: WindowTitleBarBox(
                    child: Row(children: <Widget>[
              const SizedBox(height: 8),
              Expanded(
                  child: Stack(
                      children: <Widget>[const AppTopShelf(), MoveWindow()])),
              const AppWindowTitleButtons()
            ]))),
          ),
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
                .animate(
                    autoPlay: true,
                    delay: const Duration(milliseconds: 450),
                    onComplete: (AnimationController controller) =>
                        debugSeek()["no_job_sprite_state"] = "complete",
                    onPlay: (AnimationController controller) =>
                        debugSeek()["no_job_sprite_state"] = "playing")
                .fadeIn(
                    begin: 0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 700))
                .scale(
                    begin: const Offset(0.84, 0.84),
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 450))
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: Provider.of<GlobalJobStack>(context, listen: false)
                      .jobStack
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          "${Provider.of<GlobalJobStack>(context).jobStack[index]}#${Provider.of<GlobalJobStack>(context).jobStack[index].hashCode}"),
                      onTap: () {
                        Provider.of<GlobalJobStack>(context, listen: false)
                            .removeJob(Provider.of<GlobalJobStack>(context,
                                    listen: false)
                                .jobStack[index]);
                        debugSeek()["job_stack_sz"] =
                            Provider.of<GlobalJobStack>(context, listen: false)
                                .jobStack
                                .length;
                      },
                    ).animate(autoPlay: true).fade(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 180));
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16))),
          const SizedBox(width: 8),
        ]));
  }
}
