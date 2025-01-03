import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/client/events/job_stack.dart';
import 'package:on_the_fly/client/right_menu_view.dart';
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
    // _listScrollController.addListener(() => logger.info(
    //     "ATTACHED=${_listScrollController.hasClients} ; OFFSET=${_listScrollController.offset}"));
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
            RepaintBoundary(
              child: const CanonicalAdvert()
                  .animate(delay: const Duration(milliseconds: 500))
                  .fadeIn(
                      duration: const Duration(milliseconds: 670),
                      curve: Curves.easeInOut),
            ), // end of branding section
            Expanded(
              child: ListView(
                controller: _listScrollController,
                primary: false,
                shrinkWrap: true,
                children: <Widget>[
                  for (JobDispatcher j in JobDispatcher.registeredJobDispatchers
                      .values // auto loading of all the JobDispatcher that are registered from the JobDispatcher class
                      .expand((List<JobDispatcher> e) => e))
                    Padding(
                      // title of the job dispatcher
                      padding: const EdgeInsets.only(
                        left: kTotalAppMargin,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                              useSafeArea: false,
                              context: context,
                              builder: (BuildContext context) {
                                int jobsDispatched = 0;
                                for (dynamic jobs in GlobalJobStack().jobStack) {
                                  if (j.dispatched(jobs)) {
                                    jobsDispatched++;
                                  }
                                }
                                return _JobDispatcherView(
                                    j: j, jobsDispatched: jobsDispatched);
                              });
                        },
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 14, right: 14, top: 6),
                          title: Row(
                            children: <Widget>[
                              Text(j.name),
                              const SizedBox(width: 6),
                              Container(
                                  padding: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: kThemeCmpBg,
                                      borderRadius: BorderRadius.circular(kRRArc)),
                                  child: Text(j.formatMedium.mediumName.formalize,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: kDefaultFontFamily,
                                          color: kTheme1)))
                            ],
                          ),
                          // description and like all of the "neat" details of the app such as the supported inputs and outputs formats
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(j.description),
                                  const SizedBox(height: 2),
                                  Text(
                                      "\n${InternationalizationNotifier().i18n.formatGeneric.supported_inputs}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kThemePrimaryFg1)),
                                  const SizedBox(height: 4),
                                  Wrap(
                                      runAlignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: <Widget>[
                                        for (FileFormat t in j.formatMedium.inputFormats)
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: kThemeCmpBg,
                                                  borderRadius:
                                                      BorderRadius.circular(kRRArc)),
                                              child: Text(t.canonicalName,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: kDefaultFontFamily,
                                                      color: kTheme1))),
                                      ]),
                                  const SizedBox(height: 6),
                                  Text(
                                      InternationalizationNotifier()
                                          .i18n
                                          .formatGeneric
                                          .supported_outputs,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kThemePrimaryFg1)),
                                  const SizedBox(height: 4),
                                  Wrap(
                                      runAlignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: <Widget>[
                                        for (FileFormat t in j.formatMedium.outputFormats)
                                          Container(
                                              padding: const EdgeInsets.all(4),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: kThemeCmpBg,
                                                  borderRadius:
                                                      BorderRadius.circular(kRRArc)),
                                              child: Text(t.canonicalName,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: kDefaultFontFamily,
                                                      color: kTheme2))),
                                      ]),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                  Provider.of<InternationalizationNotifier>(context)
                                      .i18n
                                      .formatGeneric
                                      .click_to_view_more,
                                  style: const TextStyle(
                                      fontSize: 12, color: kThemePrimaryFg2)),
                              const SizedBox(height: 8),
                              TextButton(
                                  onPressed: () async {
                                    if (mounted) {
                                      // Provider.of<GlobalJobStack>(context,
                                      //         listen: false)
                                      //     .addJob(SingleImgJobDispatcher());
                                      // await j.buildJobFormUI(context);
                                      // debugSeek()["job_stack_sz"] =
                                      //     Provider.of<GlobalJobStack>(context, listen: false)
                                      //         .jobStack
                                      //         .length;
                                      Provider.of<GlobalJobStack>(context, listen: false)
                                          .addJob(j.produceInitialJobInstance());
                                    }
                                  }, // TODO: proper impl job selection
                                  style: Theme.of(context)
                                      .textButtonTheme
                                      .style!
                                      .copyWith(
                                          backgroundColor:
                                              const WidgetStatePropertyAll<Color>(
                                                  kTheme1)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Icon(
                                        Ionicons.add,
                                        color: kThemeBg,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                          InternationalizationNotifier()
                                              .i18n
                                              .formatGeneric
                                              .push_job,
                                          style: const TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.w500)),
                                    ],
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

class _JobDispatcherView extends StatelessWidget {
  const _JobDispatcherView({
    required this.j,
    required this.jobsDispatched,
  });

  final JobDispatcher j;
  final int jobsDispatched;

  @override
  Widget build(BuildContext context) {
    return ImportanceDialog(
        child: Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize
              .min, // makes sure we dont talk up max vertical space for this dialog
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                      const Icon(Ionicons.bag_outline, color: kTheme1),
                      const SizedBox(width: 4),
                      Text.rich(TextSpan(
                          text: j.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: kTheme1),
                          children: <InlineSpan>[
                            TextSpan(
                                text:
                                    " ${Provider.of<InternationalizationNotifier>(context).i18n.canonicalBits.job_dispatcher_formal}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal, color: kTheme2))
                          ])),
                    ]),
                    Text.rich(TextSpan(
                        text: "ID: ",
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: j.id.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Monospaced")),
                        ])),
                    const SizedBox(height: 12),
                    const Divider(color: kThemePrimaryFg1),
                    const SizedBox(height: 12),
                    Text.rich(TextSpan(
                        text: Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .appGenerics
                            .description,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: "\n${j.properDescription}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, color: kThemePrimaryFg1))
                        ])),
                    const SizedBox(height: 8),
                    Text.rich(TextSpan(
                        text: Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .appGenerics
                            .supported_input_file_extensions,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: "\n${j.formatMedium.prettyifyInputFormats}",
                              style: const TextStyle(
                                  fontFamily: "Monospace",
                                  fontWeight: FontWeight.normal,
                                  color: kThemePrimaryFg1))
                        ])),
                    const SizedBox(height: 8),
                    Text.rich(TextSpan(
                        text: Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .appGenerics
                            .supported_output_file_extensions,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: "\n${j.formatMedium.prettifyOutputFormats}",
                              style: const TextStyle(
                                  fontFamily: "Monospace",
                                  fontWeight: FontWeight.normal,
                                  color: kThemePrimaryFg1))
                        ])),
                    const SizedBox(height: 8),
                    Text.rich(TextSpan(
                        text: Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .appGenerics
                            .dispatched_amount,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                              text: "\n$jobsDispatched",
                              style: const TextStyle(
                                  fontFamily: "Monospace",
                                  fontWeight: FontWeight.normal,
                                  color: kThemePrimaryFg1))
                        ])),
                    const SizedBox(height: 8),
                    Text.rich(TextSpan(
                        text:
                            "${Provider.of<InternationalizationNotifier>(context).i18n.appGenerics.processor}\n",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          const WidgetSpan(child: Icon(Icons.memory_rounded, size: 16)),
                          TextSpan(
                              text:
                                  " ${j.routineProcessor}#${j.routineProcessor.hashCode}",
                              style: const TextStyle(
                                  fontFamily: "Monospace",
                                  fontWeight: FontWeight.normal,
                                  color: kThemePrimaryFg1))
                        ])),
                  ]),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Tooltip(
            message: Provider.of<InternationalizationNotifier>(context, listen: false)
                .i18n
                .appGenerics
                .close,
            child: IconButton(
              style: Theme.of(context).iconButtonTheme.style!.copyWith(
                  backgroundColor: const WidgetStatePropertyAll<Color>(kTheme1)),
              onPressed: () {
                logger.info("REMOVE_JOB_DISPATCHER_INFO_VIEW");
                Navigator.of(context).pop();
              },
              icon: const Icon(Ionicons.close),
            ),
          ),
        ),
      ],
    ));
  }
}

// class _MouseDodgeHover extends StatelessWidget {
//   final Widget child;

//   const _MouseDodgeHover({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//         child: Tilt(
//       lightConfig: const LightConfig(disable: true),
//       shadowConfig: const ShadowConfig(disable: true),
//       tiltConfig: const TiltConfig(
//           angle: 2.8,
//           moveCurve: Curves.ease,
//           leaveCurve: Curves.easeInOut,
//           enableRevert: true,
//           enableReverse: true),
//       child: child,
//     ));
//   }
// }

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
          ]
              // ], inner: <Widget>[
              //   Positioned(
              //       // left and top parameters are derived from DrawerHeader's padding default edgeinsets parameter
              //       //
              //       // another thing for these parameters is that if you want initial dropshadows, adjust them with
              //       // additional offsets
              //       //
              //       // to simply just overlay them on the original text without initial dropshadows
              //       // use "16+kTotalAppMargin"
              //       left: 16 + kTotalAppMargin,
              //       top: 16,
              //       child: TiltParallax(
              //         size: const Offset(2, 2),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: <Widget>[
              //             Text(InternationalizationNotifier().i18n.appGenerics.canonical_title,
              //                 style: const TextStyle(
              //                     // fontsize can be out of sync with the bottom layer to add some parallax
              //                     fontSize: 28,
              //                     color: kThemeBg,
              //                     fontWeight: FontWeight.bold)),
              //           ],
              //         ),
              //       )),
              // ]
              ),
          child: DrawerHeader(
              margin: const EdgeInsets.only(
                  left: kTotalAppMargin, bottom: 8, top: kTotalAppMargin),
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
                                  icon: HugeIcons.strokeRoundedLicenseMaintenance,
                                  color: kThemePrimaryFg1),
                              onPressed: () => showLicensePage(
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
