import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:vector_math/vector_math_64.dart';

// oh yea btw for this piece of code, there are some hints for the dart formatter
// on making sure the formatting doesnt get fucked for initializing a matrix
// object. such that the following:
//
// Matrix4(
//  1,0,0,0
//  . . . .
//  0,0,1,1,
//
// )
//
// doesnt get malformed into
//
// Matrix4(1,0,0,...,1,1)
//
// which is fucking unreadable lmao
//
// check it out here
// https://github.com/dart-lang/dart_style/wiki/FAQ#why-does-the-formatter-mess-up-my-collection-literals
//
//
// additionally, here are some other material resources i used to
// implement the stuffs here
//
// 1. lecture slides on perspective:
// https://web.archive.org/web/20200111010231/http://web.iitd.ac.in/~hegde/cad/lecture/L9_persproj.pdf
//
// 2. https://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/building-basic-perspective-projection-matrix.html
//

class Projections {
  Projections._();
  static Matrix4 get ortho => Matrix4(
        1, 0, 0, 0, //
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      );

  static Matrix4 get identity => Matrix4.identity();

  /// retrieves the first 3x3 linear transformations
  ///
  /// consists of:
  /// 1. local scaling
  /// 2. shear
  /// 3. rotation
  /// 4. reflection
  static Matrix3 lookupLinearTransformations(Matrix4 matrix) => Matrix3(
        matrix[0], matrix[1], matrix[2], //
        matrix[4], matrix[5], matrix[6],
        matrix[8], matrix[9], matrix[10],
      );

  static Vector3 lookupPerspectiveTransformations(Matrix4 matrix) => Vector3(
        matrix[3], //
        matrix[7],
        matrix[11],
      );

  /// translations for x,y,z
  ///
  /// [ a b c p ]
  /// [ d e i q ]
  /// [ g i j r ]
  /// [ l m n s ]
  ///
  /// row vector of [ l m n ]
  static Vector3 lookupTranslations(Matrix4 matrix) => Vector3(
        matrix[12], //
        matrix[13],
        matrix[14],
      );

  static double lookupOverallScaling(Matrix4 matrix) => matrix[16];

  static double scalingFactor(double angleOfView) =>
      1.0 / tan(angleOfView * 0.5 * pi / 180.0);

  static Vector3 pointMatrixMult(Vector3 p1, Matrix4 matrix) {
    Vector3 res = Vector3.zero();
    res.x = p1.x * matrix[0] + p1.y * matrix[4] + p1.z * matrix[8] + matrix[12];
    res.y = p1.x * matrix[1] + p1.y * matrix[5] + p1.z * matrix[9] + matrix[13];
    res.z = p1.x * matrix[2] + p1.y * matrix[6] + p1.z * matrix[10] + matrix[14];
    double factor = p1.x * matrix[3] + p1.y * matrix[7] + p1.z * matrix[11] + matrix[15];
    if (factor != 1) {
      res.x /= factor;
      res.y /= factor;
      res.z /= factor;
    }
    return res;
  }
}

class MouseDodgeTransformer extends StatefulWidget {
  final Widget child;

  const MouseDodgeTransformer({super.key, required this.child});

  @override
  State<MouseDodgeTransformer> createState() => _MouseDodgeTransformerState();
}

class _MouseDodgeTransformerState extends State<MouseDodgeTransformer> {
  late Matrix4 m;
  late Offset ptr;

  @override
  void initState() {
    super.initState();
    m = Projections.ortho;
    ptr = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onHover: (PointerHoverEvent event) {
          setState(() => ptr = event.localPosition);
          logger.info(// ! NOT FINAL, REMOVE FOR PRODUCTION
              "DodgeTransformer#$hashCode -> ${event.localPosition.dx},${event.localPosition.dy} (delta = ${event.localDelta.direction},${event.localDelta.distance})");
          logger.info("pmat=\n$m");
        },
        child: Transform(
          transform: m..setEntry(0, 0, 1 / tan(ptr.dx)),
          child: widget.child,
        ),
      ),
    );
  }
}
