import 'package:auto_img/core/core.dart';
import 'package:auto_img/parts/components/text_basis.dart';
import 'package:auto_img/shared/app.dart';
import 'package:auto_img/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kRRArc),
                  topRight: Radius.circular(kRRArc)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: <Color>[
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
                    StylizedText("AutoImg",
                        style: const TextStyle(
                            fontSize: 24,
                            color: kThemePrimaryFg1,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text("Auto convert image files",
                    style: TextStyle(fontSize: 14)),
                const Text("v$kStrVerCode",
                    style: TextStyle(fontSize: 12)),
                const Spacer(),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      TextButton.icon(
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll<Color>(
                                      kThemePrimaryFg1),
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(
                                      kThemeBg)),
                          onPressed: () => showLicensePage(
                              applicationLegalese:
                                  "Jiaming Meng (net.exoad)",
                              context: context,
                              applicationVersion: kStrVerCode),
                          label: const Text("Info"),
                          icon: const HugeIcon(
                              icon: HugeIcons
                                  .strokeRoundedLicenseMaintenance,
                              color: kThemePrimaryFg1)),
                      TextButton.icon(
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll<Color>(
                                      kThemePrimaryFg1),
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(
                                      kThemeBg)),
                          onPressed: () async =>
                              await launchUrlString(kAppGitHubURL),
                          label: const Text("GitHub"),
                          icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedGithub01,
                              color: kThemePrimaryFg1)),
                    ])
              ],
            ),
          ),
          for (Jobs j in Jobs.registeredJobs.values)
            Padding(
              padding:
                  const EdgeInsets.only(left: 6, right: 6, bottom: 8),
              child: ExpansionTile(
                dense: false,
                showTrailingIcon: false,
                enableFeedback: false,
                title: Text(j.name),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(j.description),
                        const Text("\nSupported Inputs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Wrap(
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment:
                                WrapCrossAlignment.start,
                            children: <Widget>[
                              for (ImgFileTypes t in j.inputTypes)
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: kThemeCmpBg,
                                        borderRadius:
                                            BorderRadius.circular(
                                                kRRArc)),
                                    child: Text(t.name,
                                        style: const TextStyle(
                                            fontFamily:
                                                kDefaultFontFamily,
                                            color: kTheme1))),
                            ]),
                        const SizedBox(height: 6),
                        const Text("Supported Outputs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Wrap(
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment:
                                WrapCrossAlignment.start,
                            children: <Widget>[
                              for (ImgFileTypes t in j.outputTypes)
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: kThemeCmpBg,
                                        borderRadius:
                                            BorderRadius.circular(
                                                kRRArc)),
                                    child: Text(t.name,
                                        style: const TextStyle(
                                            fontFamily:
                                                kDefaultFontFamily,
                                            color: kTheme2))),
                            ]),
                      ],
                    ),
                    const SizedBox(height: 16),
                    IntrinsicHeight(
                      child: FilledButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: <Widget>[
                              HugeIcon(
                                  icon:
                                      HugeIcons.strokeRoundedPlusSign,
                                  color: kThemeBg),
                              SizedBox(width: 8),
                              Text("Add Job",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kThemeBg,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRRArc)),
              ),
            )
        ],
      ),
    );
  }
}
