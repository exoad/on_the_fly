import 'dart:ui';

import 'package:mesh/mesh.dart';

final OMeshRect meshRect = OMeshRect(
  width: 3,
  height: 4,
  fallbackColor: const Color(0xff0e0e0e),
  backgroundColor: const Color(0xff000000),
  vertices: <OVertex>[
    (0, -0.17).v.bezier(
          east: (0.07, -0.0).v,
          south: (-0.07, 0.14).v,
        ),
    (0.97, -0.1).v.bezier(
          east: (1.32, -0.05).v,
          south: (0.46, 0.19).v,
          west: (0.85, -0.24).v,
        ),
    (1.15, 0.2).v.bezier(
          west: (1.21, 0.27).v,
        ),
    (-0.13, 0.31).v.bezier(
          north: (-0.13, 0.16).v,
        ),
    (0.47, 0.45).v.bezier(
          north: (0.49, 0.45).v,
          east: (0.88, 0.47).v,
          south: (0.18, 0.55).v,
          west: (0.05, 0.48).v,
        ),
    (1.19, 0.35).v.bezier(
          west: (1.08, 0.51).v,
        ),
    (-0.31, 0.87).v.bezier(
          north: (-0.29, 0.75).v,
          east: (-0.19, 0.76).v,
          south: (-0.45, 0.91).v,
        ),
    (0.46, 0.89).v.bezier(
          north: (0.37, 0.66).v,
          east: (0.67, 0.9).v,
          south: (0.47, 0.91).v,
          west: (0.11, 0.83).v,
        ),
    (1.1, 0.6).v.bezier(
          north: (1.13, 0.53).v,
          south: (1.02, 0.57).v,
          west: (0.88, 0.56).v,
        ),
    (-0.05, 1.11).v.bezier(
          north: (-0.33, 0.79).v,
          east: (0.13, 1.06).v,
        ),
    (0.55, 1.12).v.bezier(
          north: (0.56, 1.03).v,
          east: (0.76, 1.15).v,
          west: (0.43, 1.11).v,
        ),
    (1.11, 1.11).v.bezier(
          north: (1.08, 0.96).v,
          west: (1.04, 1.09).v,
        ),
  ],
  colors: const <Color?>[
    Color(0x5af49968),
    Color(0x0f08060f),
    Color(0x0f0f0606),
    Color(0xffffb266),
    Color(0xffffe7bf),
    Color(0xff9b2f5f),
    Color(0xffe27e2d),
    Color(0xff1ab190),
    Color(0xff9b4f97),
    Color(0xff090002),
    Color(0xff1d103b),
    Color(0xff0f0012),
  ],
);
