// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/components/prefers.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/logging_view.dart';
import 'package:on_the_fly/client/right_menu_view.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/job/job_base.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';

/// left side of the app, this is used for displaying all of the JobDispatcher that the user can choose from
///
/// it is connected with the [AppRightMenuView] to display the user created JobDispatcher selected from this view.
///
/// this view also holds the branding of the app at the top of the [Drawer]
class AppLeftMenuView extends StatefulWidget {
  const AppLeftMenuView({super.key});

  @override
  State<AppLeftMenuView> createState() => _AppLeftMenuViewState();
}

class _AppLeftMenuViewState extends State<AppLeftMenuView> {
  late ScrollController _listScrollController;
  late bool _expandAllAdverts;

  @override
  void initState() {
    super.initState();
    _listScrollController = ScrollController();
    _expandAllAdverts = false;
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.zero)),
        child: Column(
          children: <Widget>[
            const CanonicalAdvert()
                .animate(delay: const Duration(milliseconds: 500))
                .fadeIn(
                    duration: const Duration(milliseconds: 670),
                    curve: Curves.easeInOut), // end of branding section
            // section: the controller buttons for the list
            Padding(
              padding: const EdgeInsets.only(left: kTotalAppMargin, top: 6, bottom: 6),
              child: Row(children: <Widget>[
                Expanded(
                    child: PrefersTextButtonIcon(
                        style: Theme.of(context).textButtonTheme.style!.copyWith(
                            backgroundColor:
                                const WidgetStatePropertyAll<Color>(kTheme2)),
                        label: _expandAllAdverts
                            ? const Text("Collapse All")
                            : const Text("Expand All"),
                        icon: _expandAllAdverts
                            ? const Icon(Ionicons.arrow_up)
                            : const Icon(Ionicons.arrow_down),
                        onPressed: () =>
                            setState(() => _expandAllAdverts = !_expandAllAdverts))),
                const SizedBox(width: kTotalAppMargin),
                Expanded(
                  child: PrefersOutlinedButtonIcon(
                      label: const Text("Refresh"),
                      icon: const Icon(Ionicons.refresh),
                      onPressed: () => wbpfcb((_) => setState(IGNORE_INVOKE))),
                )
              ]),
            ).animate().fade(
                begin: 0,
                end: 1,
                delay: const Duration(milliseconds: 120),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut),
            // const Padding(
            //   padding: EdgeInsets.only(left: kTotalAppMargin, bottom: kTotalAppMargin),
            //   child: IntrinsicHeight(
            //       child: Divider(
            //     color: kThemePrimaryFg2,
            //     thickness: 1,
            //   )),
            // ),
            // section: all the adverts proceeding
            Expanded(
              child: ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                controller: _listScrollController,
                primary: false,
                shrinkWrap: true,
                children: <Widget>[
                  for (MapEntry<String, JobAdvert> advert
                      in ConversionService.adverts.entries)
                    _AdvertCard(advert: advert, initExpanded: _expandAllAdverts)
                        .animate(delay: const Duration(milliseconds: 400))
                        .moveY(
                            begin:
                                14, // i fucking hate odd numbers so it wasnt 15, bro fuck odd numbers in graphics bruh, idk why i hate odd numbers so fucking much. man, i just dont like them. (i am a d1 odd number hater hatin)
                            end: 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 600))
                        .fadeIn(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvertCard extends StatefulWidget {
  final MapEntry<String, JobAdvert> advert;
  final bool initExpanded;
  const _AdvertCard({required this.advert, this.initExpanded = false});

  @override
  State<_AdvertCard> createState() => _AdvertCardState();
}

class _AdvertCardState extends State<_AdvertCard> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initExpanded;
  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = Text(widget.advert.value.title.value,
            style: _expanded
                ? Theme.of(context).listTileTheme.titleTextStyle
                : const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
        .gradientify(
            colors: <Color>[kTheme1, kTheme2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight);
    Widget addWidget = PrefersTextButtonIcon(
        onPressed: () async {
          if (mounted) {
            // TODO: implement this shit
          }
        }, // TODO: proper impl job selection
        style: Theme.of(context)
            .textButtonTheme
            .style!
            .copyWith(backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1)),
        label: Text(InternationalizationNotifier().i18n.appGenerics.add_this,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        icon: const Icon(
          Ionicons.add,
        ));
    return Padding(
      // this part was originally scraped from an older format-segregated approach
      padding: const EdgeInsets.only(
          left: kTotalAppMargin, top: kTotalAppMargin, bottom: kTotalAppMargin),
      child: GestureDetector(
        onTap: () {
          //? we will add more stuffs here later on
          //? my lazy ass cant do it right now
          setState(() => _expanded = !_expanded);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRRArc), color: kThemePrimaryFg3),
          // description and like all of the "neat" details of the app such as the supported inputs and outputs formats
          child: AnimatedSize(
            duration: const Duration(milliseconds: 330),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) =>
                    ScaleTransition(scale: animation, child: child),
                duration: const Duration(milliseconds: 330),
                reverseDuration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: _expanded
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          titleWidget,
                          const SizedBox(height: 4),
                          Text(widget.advert.value.description.value,
                              style: const TextStyle(color: kThemePrimaryFg2)),
                          const SizedBox(height: 4),
                          Text(
                              Provider.of<InternationalizationNotifier>(context)
                                  .i18n
                                  .jobStyleAdverts
                                  .supported_format_mediums,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 2),
                          Row(spacing: 2, children: <Widget>[
                            for (FormatMedium medium
                                in widget.advert.value.supportedMediums)
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: kThemeCmpBg,
                                      borderRadius: BorderRadius.circular(kRRArc)),
                                  child: Text(medium.mediumName.value,
                                      style: const TextStyle(
                                          color: kTheme2,
                                          fontWeight: FontWeight.w500))),
                          ]),
                          const SizedBox(height: 16),
                          addWidget
                        ],
                      )
                    : _MinimalAdvert(titleWidget: titleWidget, addWidget: addWidget)),
          ),
        ),
      ),
    );
  }
}

class _MinimalAdvert extends StatelessWidget {
  const _MinimalAdvert({
    required this.titleWidget,
    required this.addWidget,
  });

  final Widget titleWidget;
  final Widget addWidget;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  titleWidget,
                  Text(
                      Provider.of<InternationalizationNotifier>(context)
                          .i18n
                          .jobStyleAdverts
                          .adverts_click_for_more_actions,
                      style: const TextStyle(fontSize: 12, color: kThemePrimaryFg2))
                ]),
            const Spacer(),
            addWidget
          ]),
    );
  }
}

/// describes the drawer header graphic bit
class CanonicalAdvert extends StatefulWidget {
  const CanonicalAdvert({
    super.key,
  });

  @override
  State<CanonicalAdvert> createState() => _CanonicalAdvertState();
}

class _CanonicalAdvertState extends State<CanonicalAdvert> {
  bool _expanded = true;

  static const double _titleFontSize = 32;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        logger.info("CanonicalAdvert_expanded: $_expanded -> ${!_expanded}");
        _expanded = !_expanded;
      }),
      child: AnimatedCrossFade(
        sizeCurve: Curves.easeInOut,
        secondCurve: Curves.easeInOutExpo,
        firstCurve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 690), // haha 69, funny number for real !
        crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        secondChild: Tooltip(
          message:
              Provider.of<InternationalizationNotifier>(context).i18n.appGenerics.menu,
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Ionicons.ellipsis_horizontal)]),
        ),
        firstChild: Tilt(
          lightConfig: const LightConfig(disable: true),
          shadowConfig: const ShadowConfig(disable: true),
          tiltConfig: const TiltConfig(
              angle: 4,
              moveCurve: Curves.ease,
              leaveCurve: Curves.easeInOut,
              enableRevert: true,
              enableReverse: true),
          childLayout: ChildLayout(outer: <Widget>[
            Positioned(
                // left and top parameters are derived from DrawerHeader's padding default edgeinsets parameter
                //
                // another thing for these parameters is that if you want initial dropshadows, adjust them with
                // additional offsets
                //
                // to simply just overlay them on the original text without initial dropshadows
                // use "16+kTotalAppMargin"
                left: 16 + kTotalAppMargin,
                top: 15,
                child: TiltParallax(
                  size: const Offset(8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          InternationalizationNotifier().i18n.appGenerics.canonical_title,
                          style: const TextStyle(
                              fontSize: _titleFontSize,
                              color: kThemePrimaryFg1,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
          ]),
          child: DrawerHeader(
              margin: const EdgeInsets.only(left: kTotalAppMargin, top: kTotalAppMargin),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kRRArc)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    // YESSSS GRADIENTS, makes the app look so fancy (but is it ?)
                    kTheme1,
                    kTheme2,
                  ],
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            InternationalizationNotifier()
                                .i18n
                                .appGenerics
                                .canonical_title,
                            style: const TextStyle(
                                fontSize: _titleFontSize,
                                color: kThemeBg,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                        InternationalizationNotifier()
                            .i18n
                            .appGenerics
                            .canonical_description,
                        style:
                            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    const Text("v$kStrVerCode", style: TextStyle(fontSize: 12)),
                    const Spacer(),
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          // previously there was an approach to have text buttons, but that seems too clustered,
                          // instead we can do away with tooltips lol
                          Tooltip(
                            message: Provider.of<InternationalizationNotifier>(context)
                                .i18n
                                .loggerView
                                .rmenu_tooltip,
                            child: IconButton(
                              style: ButtonStyle(
                                  visualDensity: VisualDensity.standard,
                                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(99999))),
                                  foregroundColor: const WidgetStatePropertyAll<Color>(
                                      kThemePrimaryFg1),
                                  backgroundColor:
                                      const WidgetStatePropertyAll<Color>(kThemeBg)),
                              icon: const HugeIcon(
                                  icon: HugeIcons
                                      .strokeRoundedCode, // might not be the best icon, for some reaosn it doesnt bundle all of the icons from the hugeicon site since i think a preferred iconw ould be like "terminal"
                                  color: kThemePrimaryFg1),
                              onPressed: () => showDialog(
                                  context: context,
                                  useSafeArea: false,
                                  builder: (BuildContext context) =>
                                      const LoggingView()), // TODO: impl
                            ),
                          ),
                          Tooltip(
                            message: Provider.of<InternationalizationNotifier>(context)
                                .i18n
                                .appGenerics
                                .github,
                            child: IconButton(
                              style: ButtonStyle(
                                  visualDensity: VisualDensity.standard,
                                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(99999))),
                                  foregroundColor: const WidgetStatePropertyAll<Color>(
                                      kThemePrimaryFg1),
                                  backgroundColor:
                                      const WidgetStatePropertyAll<Color>(kThemeBg)),
                              icon: const HugeIcon(
                                  icon: HugeIcons.strokeRoundedScroll,
                                  color: kThemePrimaryFg1),
                              onPressed: () => showLicensePage(
                                  applicationName:
                                      Provider.of<InternationalizationNotifier>(context,
                                              listen: false)
                                          .i18n
                                          .appGenerics
                                          .canonical_title,
                                  applicationIcon: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      spacing: 10,
                                      children: <Widget>[
                                        Image.asset("assets/AppIcon.png",
                                            width: 80, height: 80),
                                        Image.asset("assets/AppIcon_2.png",
                                            width: 80, height: 80),
                                      ],
                                    ),
                                  ),
                                  applicationLegalese:
                                      Provider.of<InternationalizationNotifier>(context,
                                              listen: false)
                                          .i18n
                                          .appGenerics
                                          .author_name,
                                  context: context,
                                  applicationVersion: kStrVerCode),
                            ),
                          ),
                          Tooltip(
                            message: Provider.of<InternationalizationNotifier>(context,
                                    listen: false)
                                .i18n
                                .appGenerics
                                .third_parties,
                            child: IconButton(
                                style: ButtonStyle(
                                    visualDensity: VisualDensity.standard,
                                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(99999))),
                                    foregroundColor: const WidgetStatePropertyAll<Color>(
                                        kThemePrimaryFg1),
                                    backgroundColor:
                                        const WidgetStatePropertyAll<Color>(kThemeBg)),
                                onPressed: () async =>
                                    await launchUrlString(kAppGitHubURL),
                                icon: const HugeIcon(
                                    icon: HugeIcons.strokeRoundedGithub01,
                                    color: kThemePrimaryFg1)),
                          ),
                        ])
                  ])),
        ),
      ),
    );
  }
}
