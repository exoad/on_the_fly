import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:on_the_fly/shared/theme.dart';

class JobTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const JobTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: <double>[0.1, 0.9],
              colors: <Color>[kTheme2, kTheme1],
            ).createShader(bounds);
          },
          child: Text(title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: kThemePrimaryFg1)),
        ),
        const SizedBox(height: 4),
        Row(children: <Widget>[
          const Icon(Ionicons.time_outline, color: kThemePrimaryFg2, size: 14),
          const SizedBox(width: 4),
          Text.rich(TextSpan(
              text: "Created on: ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: kThemePrimaryFg2),
              children: <TextSpan>[
                TextSpan(
                    text: subtitle, style: const TextStyle(fontWeight: FontWeight.w300))
              ]))
        ]),
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 10),
        //   child: Divider(
        //     color: kThemePrimaryFg3,
        //     thickness: 2,
        //   ),
        // ),
      ],
    );
  }
}
