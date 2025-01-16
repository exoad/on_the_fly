import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:on_the_fly/client/app_view.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_the_fly/client/events/debug_events.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

/// this side of the app displays the jobs created and other important information
///
/// located of course, on the right side of the application
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
                if (Provider.of<JobStack>(context).isEmpty())
                  RepaintBoundary(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: 250,
                            height: 200,
                            child: SvgPicture.asset("assets/illust/undraw_loading.svg",
                                clipBehavior: Clip.antiAlias,
                                cacheColorFilter: true,
                                height: 180)),
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
                          delay: const Duration(milliseconds: 340),
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
                          duration: const Duration(milliseconds: 510))
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _JobStackView(),
                    ),
                  ),
              ]),
          const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      height: kWindowShelfHeight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: kTotalAppMargin, left: kTotalAppMargin * 2),
                        child: AppTopShelf(),
                      )))
              .animate(autoPlay: true, delay: const Duration(milliseconds: 400))
              .fadeIn(
                  begin: 0,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 270))
              .slideY(
                  begin: 0.02,
                  end: 0,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 230)),
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

class _JobStackView extends StatelessWidget {
  // final GlobalKey<AnimatedListState> _listKey;
  final ScrollController _scrollController;

  _JobStackView()
      :
        // _listKey = GlobalKey<AnimatedListState>(),
        _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final int jobStackLen = Provider.of<JobStack>(context, listen: false).length;
    return Scrollbar(
      controller: _scrollController,
      child: SuperListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: jobStackLen,
          itemBuilder: (BuildContext context, int index) {
            index = (jobStackLen - 1) - index;
            Widget contentW = Padding(
                padding: const EdgeInsets.only(bottom: kListComponentsSpacing),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).listTileTheme.tileColor,
                        borderRadius: BorderRadius.circular(kRRArc)),
                    child: const SizedBox()
                    // child: Provider.of<JobStack>(context)[index].buildForm(context),
                    // onTap: () {
                    //   Provider.of<GlobalJobStack>(context, listen: false)
                    //       .removeJob(Provider.of<GlobalJobStack>(context,
                    //               listen: false)
                    //           .jobStack[index]);
                    //   debugSeek()["job_stack_sz"] =
                    //       Provider.of<GlobalJobStack>(context,
                    //               listen: false)
                    //           .jobStack
                    //           .length;
                    // },
                    ));
            // we add some end or begin padding to the list view scroll element for this
            // job instance form
            return (index == jobStackLen - 1
                    ? Padding(padding: const EdgeInsets.only(top: 40), child: contentW)
                    : contentW)
                .animate(delay: const Duration(milliseconds: 50), autoPlay: true)
                .scale(
                    begin: const Offset(0.97, 0.97),
                    end: const Offset(1, 1),
                    curve: Curves.easeInOut,
                    delay: const Duration(milliseconds: 50),
                    duration: const Duration(milliseconds: 260))
                .fadeIn(
                  begin: 0,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 260),
                );
          }),
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
          Text("${InternationalizationNotifier().i18n.appGenerics.job_count}: ${Provider.of<JobStack>(context).length}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              .blurry(
                  blur: 10,
                  elevation: 16,
                  borderRadius: BorderRadius.circular(kRRArc),
                  color: kThemePrimaryFg1.withAlpha((0.08 * 255).round())),
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
