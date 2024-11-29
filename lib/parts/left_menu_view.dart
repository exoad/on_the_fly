import 'package:on_the_fly/core/core.dart';
import 'package:on_the_fly/core/utils/strings.dart';
import 'package:on_the_fly/parts/components/text_basis.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// left side of the app, this is used for displaying all of the jobs that the user can choose from
///
/// it is connected with the [AppRightMenuView] to display the user created jobs selected from this view.
///
/// this view also holds the branding of the app at the top of the [Drawer]
class AppLeftMenuView extends StatelessWidget {
  const AppLeftMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        primary: true,
        children: <Widget>[
          DrawerHeader(
            // app branding section lol
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRRArc),
                  topRight: Radius.circular(kRRArc)),
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
                      TextButton.icon(
                          style: const ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll<Color>(
                                  kThemePrimaryFg1),
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(kThemeBg)),
                          onPressed: () => showLicensePage(
                              applicationLegalese: "Jiaming Meng (net.exoad)",
                              context: context,
                              applicationVersion: kStrVerCode),
                          label: const Text("Info"),
                          icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedLicenseMaintenance,
                              color: kThemePrimaryFg1)),
                      TextButton.icon(
                          style: const ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll<Color>(
                                  kThemePrimaryFg1),
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(kThemeBg)),
                          onPressed: () async =>
                              await launchUrlString(kAppGitHubURL),
                          label: const Text("GitHub"),
                          icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedGithub01,
                              color: kThemePrimaryFg1)),
                    ])
              ],
            ),
          ), // end of branding section
          for (Jobs<FileFormat> j in Jobs.registeredJobs
              .values // auto loading of all the jobs that are registered from the Jobs class
              .expand((List<Jobs<FileFormat>> e) => e))
            Padding(
              // title of the job
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 8),
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
                          onPressed: () {}, // TODO: impl job selection
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
        ],
      ),
    );
  }
}
