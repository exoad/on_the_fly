import 'package:auto_img/parts/components/text_basis.dart';
import 'package:auto_img/shared/app.dart';
import 'package:auto_img/shared/theme.dart';
import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRRArc),
              gradient: const LinearGradient(
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<
                                      Color>(
                                  kThemePrimaryFg1.withOpacity(0.3))),
                          onPressed: () {},
                          icon: const Icon(Icons.search)),
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
