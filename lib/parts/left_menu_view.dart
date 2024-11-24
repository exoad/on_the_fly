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
                StylizedText("AutoImg",
                    style: const TextStyle(
                        fontSize: 24,
                        color: kThemePrimaryFg1,
                        fontWeight: FontWeight.bold)),
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
                      // TextButton.icon(
                      //     style: const ButtonStyle(
                      //         foregroundColor:
                      //             WidgetStatePropertyAll<Color>(
                      //                 kThemePrimaryFg1),
                      //         backgroundColor:
                      //             WidgetStatePropertyAll<Color>(
                      //                 kThemeBg)),
                      //     onPressed: () => showLicensePage(
                      //         applicationLegalese:
                      //             "Jiaming Meng (net.exoad)",
                      //         context: context,
                      //         applicationVersion: kStrVerCode),
                      //     label: const Text("Info"),
                      //     icon: const HugeIcon(
                      //         icon: HugeIcons
                      //             .strokeRoundedLicenseMaintenance,
                      //         color: kThemePrimaryFg1)),
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
          const ListTile(
            title: Text('Item 1'),
          ),
          const ListTile(
            title: Text('Item 2'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
          const ListTile(
            title: Text('Item 3'),
          ),
        ],
      ),
    );
  }
}
