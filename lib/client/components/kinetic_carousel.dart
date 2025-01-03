import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_the_fly/helpers/basics.dart';

/// a spinner kind of animation that uses widgets as the spinning bits
///
/// also has a scale up animation that randomly chooses one of the widgets
/// and scales it up
class KineticCarouselAnimator extends StatefulWidget {
  static const double kScaleUpFactor = 1.24;
  static const Duration kScaleUpAnimationDuration = Duration(milliseconds: 740);
  static const Duration kScaleUpAnimationDelay = Duration(milliseconds: 400);
  static const Duration kScaleUpPeriod = Duration(milliseconds: 2500);
  static const Duration kPeriod = Duration(milliseconds: 9000);

  final Duration period;
  final double radius;
  final bool allowScalingUpAnimation;
  final Duration? scaleUpPeriod;
  final Duration? scaleUpAnimationDuration;
  final Duration? scaleUpAnimationDelay;
  final double? scaleUpFactor;
  final double thetaModifier;
  final Curve? scaleUpCurve;
  final List<Widget> children;

  /// constructs the animator widget. if you don't have values to use for any values
  /// with the 'scaleUp' prefix. you can check out the static constants in this class
  /// that are provided. such as [kScaleUpFactor], [kScaleUpAnimationDuration], and [kScaleUpPeriod]
  /// which matches to their respective values. [kPeriod] is also another one, but it doesnt have
  /// the scale up prefix
  const KineticCarouselAnimator(
      {super.key,
      required this.period,
      required this.children,
      required this.radius,
      this.scaleUpAnimationDelay,
      this.thetaModifier = 0,
      required this.allowScalingUpAnimation,
      this.scaleUpAnimationDuration,
      this.scaleUpFactor,
      this.scaleUpCurve,
      this.scaleUpPeriod})
      : assert(
            allowScalingUpAnimation
                ? scaleUpFactor != null &&
                    scaleUpPeriod != null &&
                    scaleUpAnimationDuration != null &&
                    scaleUpCurve != null &&
                    scaleUpAnimationDelay != null
                : true,
            "If using ScalingUpAnimation, values with 'scaleUp' prefixed must be initialized !"),
        assert(children.length > 0,
            "Child Widgets list cannot be empty."); // OH WOW, NOW YOU R TELLING ME I CANT USE isNotEmpty WHEN YOU HAVE BEEN ENFORCING THAT. HOLY SHIT. FUCKING DUMB AHHHH LINTER. I HATE USING isNotEmpty and isEmpty. LIKE BRUH ???

  @override
  State<KineticCarouselAnimator> createState() => _KineticCarouselAnimatorState();
}

class _KineticCarouselAnimatorState extends State<KineticCarouselAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  /// if the scale up animation is running, if [widget.allowScalingUpAnimation] is false, this will
  /// always be false.
  bool isScAnim;
  int? scaledWidget;
  Timer? scalingTimer;

  _KineticCarouselAnimatorState() : isScAnim = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.period)
      ..repeat();
    if (widget.allowScalingUpAnimation) {
      scalingTimer = Timer.periodic(widget.scaleUpPeriod!, (_) {
        if (!isScAnim && mounted) {
          setState(() {
            scaledWidget = genRngTill(scaledWidget ?? -1, widget.children.length);
            isScAnim = true;
          });
          Future<void>.delayed(
              widget.scaleUpAnimationDuration! + widget.scaleUpAnimationDelay!, () {
            isScAnim = false;
            scaledWidget = null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Stack(
              alignment: Alignment.center,
              children: List<Widget>.generate(widget.children.length, (int index) {
                double theta = (2 * pi / 4) * index + animationController.value * 2 * pi;
                theta += widget.thetaModifier;
                Widget finalWidget = Transform.translate(
                    offset: // (dx:r*cos,dy:r*sin)
                        Offset(widget.radius * cos(theta), widget.radius * sin(theta)),
                    child: widget.children[index]);
                bool isScaledElement =
                    scaledWidget != null && scaledWidget == index && isScAnim;
                return widget.allowScalingUpAnimation
                    ? AnimatedScale(
                        scale: isScaledElement ? widget.scaleUpFactor! : 1,
                        duration: widget.scaleUpAnimationDuration!,
                        curve: widget.scaleUpCurve!,
                        child: finalWidget)
                    : finalWidget;
              }));
        });
  }
}
