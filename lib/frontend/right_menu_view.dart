import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:on_the_fly/frontend/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/frontend/events/ephemeral_stacks.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

class AppRightMenuView extends StatelessWidget {
  const AppRightMenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                            child: SvgPicture.asset("assets/illust/undraw_loading.svg",
                                height: 200)),
                        const SizedBox(height: 18),
                        Text(InternationalizationNotifier()
                            .i18n
                            .appGenerics
                            .nothing_to_do),
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
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: Provider.of<GlobalJobStack>(context, listen: false)
                            .jobStack
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? const SizedBox(height: kWindowShelfHeight)
                              : Builder(builder: (BuildContext context) {
                                  Widget contentW = Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      title: Text(
                                          "${Provider.of<GlobalJobStack>(context).jobStack[index]}#${Provider.of<GlobalJobStack>(context).jobStack[index].hashCode}"),
                                      onTap: () {
                                        Provider.of<GlobalJobStack>(context,
                                                listen: false)
                                            .removeJob(Provider.of<GlobalJobStack>(
                                                    context,
                                                    listen: false)
                                                .jobStack[index]);
                                        debugSeek()["job_stack_sz"] =
                                            Provider.of<GlobalJobStack>(context,
                                                    listen: false)
                                                .jobStack
                                                .length;
                                      },
                                    )
                                  );
                                  // we add some end padding to the list view scroll
                                  return index ==
                                          Provider.of<GlobalJobStack>(context,
                                                      listen: false)
                                                  .jobStack
                                                  .length -
                                              1
                                      ? Padding(
                                          padding: const EdgeInsets.only(bottom: 40),
                                          child: contentW)
                                      : contentW;
                                });
                        },
                      ),
                    ),
                  ),
              ]),
          const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                  height: kWindowShelfHeight,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: kTotalAppMargin, left: kTotalAppMargin * 2),
                    child: AppTopShelf(),
                  ))),
          Align(
            alignment: Alignment.topCenter,
            child: WindowTitleBarBox(
                child: Row(children: <Widget>[
              Expanded(child: MoveWindow()),
              const AppWindowTitleButtons()
            ])),
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
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${InternationalizationNotifier().i18n.appGenerics.job_count}: ${Provider.of<GlobalJobStack>(context).jobStack.length}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              .blurry(
                  blur: 10,
                  elevation: 16,
                  borderRadius: BorderRadius.circular(kRRArc),
                  color: kThemePrimaryFg1.withOpacity(0.08)),
        //   const SizedBox(width: kTotalAppMargin),
        //   Text("${InternationalizationNotifier().i18n.appGenerics.job_count}: ${Provider.of<GlobalJobStack>(context).jobStack.length}",
        //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
        //       .blurry(
        //           blur: 10,
        //           elevation: 16,
        //           borderRadius: BorderRadius.circular(kRRArc),
        //           color: kThemePrimaryFg1.withOpacity(0.08)),
        ]);
  }
}
