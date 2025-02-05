import 'package:flutter/material.dart';
import 'package:on_the_fly/helpers/basics.dart';
import 'package:on_the_fly/helpers/ranged_incrementor.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/debug_events.dart';
import 'package:on_the_fly/shared/theme.dart';

/// a debug overlay made to be immediate and easy to use as it is entirely
/// base on a map based data structure and renders custom widgets and other
/// things on demand. it is also always shown above any ui element including
/// even the window bar.
class DebugOverlayLayer extends StatefulWidget {
  const DebugOverlayLayer({
    super.key,
  });

  @override
  State<DebugOverlayLayer> createState() => _DebugOverlayLayerState();
}

class _DebugOverlayLayerState extends State<DebugOverlayLayer> {
  late Alignment _loc;
  double _width = 430;
  late RangedIncrementor _opacity;

  @override
  void initState() {
    super.initState();
    _loc = Alignment.bottomRight;
    _opacity = RangedIncrementor(initialValue: 0.76, max: 1, min: 0.2);
    debugSeek().addListener((() => setState(IGNORE_INVOKE)));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Align(
          alignment: _loc,
          child: Opacity(
            opacity: _opacity.value,
            child: SizedBox(
              width: _width,
              child: IntrinsicHeight(
                child: Container(
                    decoration: const BoxDecoration(color: kNull),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        textStyle: const TextStyle(
                            fontFamily: "Monospaced",
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                        color: Colors.transparent,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text("Debug Layer [${debugSeek().dump.length}]",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const Spacer(),
                                        CompactTextButton(
                                          "tr",
                                          onPressed: () =>
                                              setState(() => _loc = Alignment.topRight),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "tl",
                                          onPressed: () =>
                                              setState(() => _loc = Alignment.topLeft),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "bl",
                                          onPressed: () =>
                                              setState(() => _loc = Alignment.bottomLeft),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "br",
                                          onPressed: () => setState(
                                              () => _loc = Alignment.bottomRight),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "+w",
                                          onPressed: () => setState(() => _width +=
                                              _width + 10 >
                                                      MediaQuery.sizeOf(context).width
                                                  ? 0
                                                  : 10),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "0w",
                                          onPressed: () => setState(() => _width = 340),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "-w",
                                          onPressed: () => setState(
                                              () => _width -= _width - 10 < 0 ? 0 : 10),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "+o",
                                          onPressed: () =>
                                              setState(() => _opacity.increment(0.1)),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "no", // normal opacity
                                          onPressed: () =>
                                              setState(() => _opacity.value = 0.76),
                                        ),
                                        const SizedBox(width: 4),
                                        CompactTextButton(
                                          "-o",
                                          onPressed: () =>
                                              setState(() => _opacity.increment(-0.1)),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      indent: 0,
                                      endIndent: 0,
                                      thickness: 1,
                                      height: 1,
                                    ),
                                    const SizedBox(height: 6),
                                    if (debugSeek().dump.isNotEmpty)
                                      for (MapEntry<String, dynamic> entry
                                          in debugSeek().dump.entries)
                                        if (entry.value is String)
                                          Text.rich(TextSpan(
                                              text: entry.key,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              children: <InlineSpan>[
                                                TextSpan(
                                                    text:
                                                        ": ${entry.value == null ? "NULL" : entry.value.toString()}",
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w300))
                                              ]))
                                        else if (entry.value is Widget)
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(entry.key,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w500)),
                                                const SizedBox(width: 4),
                                                entry.value as Widget,
                                              ])
                                        else
                                          const Text("Nothing to dump...",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal))
                                  ],
                                ))),
                      ),
                    )),
              ),
            ),
          )),
    );
  }
}
