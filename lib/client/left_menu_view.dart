import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/client/components/prefers.dart';
import 'package:on_the_fly/client/logging_view.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/job/job_base.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/right_menu_view.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/layout.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  @override
  void initState() {
    super.initState();
    _listScrollController = ScrollController();
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
                    Padding(
                      // this part was originally scraped from an older format-segregated approach
                      padding: const EdgeInsets.only(
                          left: kTotalAppMargin, top: kTotalAppMargin * 2),
                      child: InkWell(
                        onTap: () async {
                          // TODO: implement this shit
                        },
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 14, right: 14, top: 6),
                          title: Text(advert.value.title.value).gradientify(
                              begin: alignmentValues.pickRandom(),
                              end: alignmentValues.pickRandom()),
                          // description and like all of the "neat" details of the app such as the supported inputs and outputs formats
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 4),
                              Text(advert.value.description.value,
                                  style: const TextStyle(color: kThemePrimaryFg1)),
                              const SizedBox(height: 10),
                              Text(
                                  Provider.of<InternationalizationNotifier>(context)
                                      .i18n
                                      .jobStyleAdverts
                                      .adverts_click_for_more_actions,
                                  style: const TextStyle(
                                      fontSize: 12, color: kThemePrimaryFg2)),
                              const SizedBox(height: 8),
                              PrefersTextButtonIcon(
                                  onPressed: () async {
                                    if (mounted) {
                                      // TODO: implement this shit
                                    }
                                  }, // TODO: proper impl job selection
                                  style: Theme.of(context)
                                      .textButtonTheme
                                      .style!
                                      .copyWith(
                                          backgroundColor:
                                              const WidgetStatePropertyAll<Color>(
                                                  kTheme1)),
                                  label: Text(
                                      InternationalizationNotifier()
                                          .i18n
                                          .formatGeneric
                                          .push_job,
                                      style: const TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w500)),
                                  icon: const Icon(
                                    Ionicons.add,
                                  )),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  kRRArc)), // this is j for visual purposes
                        ),
                      ),
                    )
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
      child: Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color.fromARGB(152, 0, 0, 0), offset: Offset(0, 4), blurRadius: 10, spreadRadius: 6)
        ]),
        child: AnimatedCrossFade(
          sizeCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOutExpo,
          firstCurve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 690), // haha 69, funny number for real !
          crossFadeState:
              _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                            InternationalizationNotifier()
                                .i18n
                                .appGenerics
                                .canonical_title,
                            style: const TextStyle(
                                fontSize: _titleFontSize,
                                color: kThemePrimaryFg1,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
            ]),
            child: DrawerHeader(
                margin:
                    const EdgeInsets.only(left: kTotalAppMargin, top: kTotalAppMargin),
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
                                      shape:
                                          WidgetStatePropertyAll<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(99999))),
                                      foregroundColor:
                                          const WidgetStatePropertyAll<Color>(
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
      ),
    );
  }
}
