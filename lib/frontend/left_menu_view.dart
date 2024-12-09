import 'package:flutter_animate/flutter_animate.dart';
import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/formats/images.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/frontend/components/text_basis.dart';
import 'package:on_the_fly/frontend/events/debug_events.dart';
import 'package:on_the_fly/frontend/events/job_stack.dart';
import 'package:on_the_fly/frontend/right_menu_view.dart';
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
      shape: const BeveledRectangleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration:
            const BoxDecoration(borderRadius: BorderRadius.all(Radius.zero)),
        child: ListView(
          controller: _listScrollController,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          primary: false,
          children: <Widget>[
            DrawerHeader(
              margin: const EdgeInsets.only(left: 6, bottom: 8, top: 6),
              // app branding section lol
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
                      StylizedText(kStrAppName,
                          style: const TextStyle(
                              fontSize: 24,
                              color: kThemePrimaryFg1,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text("Auto convert file formats",
                      style: TextStyle(fontSize: 14)),
                  const Text("v$kStrVerCode", style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        // !! this part with all of the kDrawerHeaderButtonsShowTexts should be moved
                        // !! to a more localized format (extern impl)
                        if (kDrawerHeaderButtonsShowTexts)
                          TextButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll<Color>(
                                          kThemePrimaryFg1),
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(kThemeBg)),
                              onPressed: () => showLicensePage(
                                  applicationLegalese:
                                      "Jiaming Meng (net.exoad)",
                                  context: context,
                                  applicationVersion: kStrVerCode),
                              label: const Text("Info"),
                              icon: const HugeIcon(
                                  icon:
                                      HugeIcons.strokeRoundedLicenseMaintenance,
                                  color: kThemePrimaryFg1))
                        else
                          IconButton.filled(
                            style: const ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll<Color>(
                                    kThemePrimaryFg1),
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(kThemeBg)),
                            icon: const HugeIcon(
                                icon: HugeIcons.strokeRoundedLicenseMaintenance,
                                color: kThemePrimaryFg1),
                            onPressed: () => showLicensePage(
                                applicationLegalese: "Jiaming Meng (net.exoad)",
                                context: context,
                                applicationVersion: kStrVerCode),
                          ),
                        if (kDrawerHeaderButtonsShowTexts)
                          TextButton.icon(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll<Color>(
                                          kThemePrimaryFg1),
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(kThemeBg)),
                              onPressed: () async =>
                                  await launchUrlString(kAppGitHubURL),
                              label: const Text("GitHub"),
                              icon: const HugeIcon(
                                  icon: HugeIcons.strokeRoundedGithub01,
                                  color: kThemePrimaryFg1))
                        else
                          IconButton.filled(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      WidgetStatePropertyAll<Color>(
                                          kThemePrimaryFg1),
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(kThemeBg)),
                              onPressed: () async =>
                                  await launchUrlString(kAppGitHubURL),
                              icon: const HugeIcon(
                                  icon: HugeIcons.strokeRoundedGithub01,
                                  color: kThemePrimaryFg1)),
                      ])
                ],
              ),
            ).animate(delay: const Duration(milliseconds: 500)).fadeIn(
                duration: const Duration(milliseconds: 670),
                curve: Curves.easeInOut), // end of branding section
            const Divider(),
            for (JobDispatcher j in JobDispatcher.registeredJobDispatchers
                .values // auto loading of all the JobDispatcher that are registered from the JobDispatcher class
                .expand((List<JobDispatcher> e) => e))
              Padding(
                // title of the job dispatcher
                padding: const EdgeInsets.only(left: 4, right: 0, bottom: 8),
                child: ExpansionTile(
                  dense: false,
                  showTrailingIcon: false,
                  enableFeedback: false,
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
                          child: Text(j.mediumName.formalize,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: kDefaultFontFamily,
                                  color: kTheme1)))
                    ],
                  ),
                  // description and like all of the "neat" details of the app such as the supported inputs and outputs formats
                  subtitle: Padding(
                    // we need this padding (top:8) so the title isn't too close to the subtitle/description
                    // of this job
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(j.description),
                            const Text("\nSupported Inputs",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: <Widget>[
                                  for (FileFormat t in j.inputTypes)
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
                            const Text("Supported Outputs",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: <Widget>[
                                  for (FileFormat t in j.outputTypes)
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
                        const SizedBox(height: 16),
                        FilledButton(
                            onPressed: () async {
                              // Provider.of<GlobalJobStack>(context,
                              //         listen: false)
                              //     .addJob(SingleImgJobDispatcher());
                              await j.buildJob(context);
                              debugSeek()["job_stack_sz"] =
                                  Provider.of<GlobalJobStack>(context,
                                          listen: false)
                                      .jobStack
                                      .length;
                            }, // TODO: proper impl job selection
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                HugeIcon(
                                    icon: HugeIcons.strokeRoundedPlusSign,
                                    color: kThemeBg),
                                SizedBox(width: 8),
                                Text("Add Job",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: kThemeBg,
                                        fontWeight: FontWeight.normal)),
                              ],
                            )),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          kRRArc)), // this is j for visual purposes
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
    );
  }
}
