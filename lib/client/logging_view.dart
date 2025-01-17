import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logging/logging.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/helpers/color_helper.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:on_the_fly/helpers/basics.dart';

import 'package:provider/provider.dart';

class LoggingView extends StatefulWidget {
  const LoggingView({super.key});

  @override
  State<LoggingView> createState() => _LoggingViewState();
}

class _LogActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final void Function() action;

  const _LogActionButton(
      {required this.action,
      required this.icon,
      required this.label,
      // ignore: unused_element
      this.color = kThemePrimaryFg1});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: TextButton(
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 4)),
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc))),
              visualDensity: VisualDensity.compact,
              backgroundColor: WidgetStatePropertyAll<Color>(color)),
          onPressed: action,
          child: Icon(icon)),
    );
  }
}

void pushbackLogRecord(LogRecord record) {
  _logHistory.add(record);
  _repaint?.call();
}

List<LogRecord> _logHistory = <LogRecord>[];
/*late*/ void Function()? _repaint;

class _LoggingViewState extends State<LoggingView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _repaint = () => setState(IGNORE_INVOKE);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _repaint = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TitledImportanceDialog(
      title: Row(
        children: <Widget>[
          Text(Provider.of<InternationalizationNotifier>(context).i18n.loggerView.title,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: kTheme1)),
          const SizedBox(width: 20),
          _LogActionButton(
              icon: Ionicons.trash,
              action: () => wbpfcb((_) => setState(_logHistory.clear)),
              label: Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .clear),
          const SizedBox(width: 6),
          _LogActionButton(
              icon: Ionicons.arrow_down,
              action: () async => await _scrollController.animateTo(
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeInOut,
                  _scrollController.position.maxScrollExtent),
              label: Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .scroll_to_bottom),
          const SizedBox(width: 6),
          _LogActionButton(
              icon: Ionicons.arrow_up,
              action: () async => await _scrollController.animateTo(
                  duration: const Duration(milliseconds: 520),
                  curve: Curves.easeInOut,
                  _scrollController.position.minScrollExtent),
              label: Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .appGenerics
                  .scroll_to_top),
          const SizedBox(width: 6),
          _LogActionButton(
              icon: Ionicons.time,
              action: () => logger.fine(
                  "Uptime: ${Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - AppDebug().startUpTimestamp)}"),
              label: Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .loggerView
                  .log_uptime),
        ],
      ),
      child: Expanded(
        child: _logHistory.isEmpty
            ? Center(
                child: RepaintBoundary(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 250,
                          height: 200,
                          child: SvgPicture.asset("assets/illust/undraw_taken.svg",
                              clipBehavior: Clip.antiAlias,
                              cacheColorFilter: true,
                              height: 180)),
                      const SizedBox(height: 18),
                      Text(
                        Provider.of<InternationalizationNotifier>(context)
                            .i18n
                            .appGenerics
                            .empty,
                      )
                          .animate(delay: const Duration(milliseconds: 140))
                          .fadeIn(
                              duration: const Duration(milliseconds: 320),
                              curve: Curves.easeIn)
                          .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                              duration: const Duration(milliseconds: 340),
                              delay: const Duration(milliseconds: 180),
                              curve: Curves.easeIn),
                    ],
                  ),
                )
                    .animate(autoPlay: true, delay: const Duration(milliseconds: 340))
                    .fadeIn(
                        begin: 0,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 700))
                    .scale(
                        begin: const Offset(0.84, 0.84),
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 510)),
              )
            : ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _logHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  LogStyle style = loggingColors(_logHistory[index].level);
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: IntrinsicHeight(
                      child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(width: 26),
                          child: Center(
                            child: Text("${index + 1}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.bipartiteContrast())),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(width: 210),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRRArc),
                                border: Border.all(color: style.color, width: 1.5)),
                            child: Center(
                              child: Text(
                                  _logHistory[index].time.toString().replaceAll("\n", ""),
                                  style: TextStyle(
                                      color: style.color,
                                      fontSize: 12,
                                      fontWeight: style.isBold
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(width: 90),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRRArc),
                                color: style.color),
                            child: Center(
                              child: Text(_logHistory[index].level.name,
                                  style: TextStyle(
                                      color: style.foreground,
                                      fontSize: 12,
                                      fontWeight: style.isBold
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            child: DefaultSelectionStyle(
                              child: Text(_logHistory[index].message,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: style.color,
                                      fontSize: 12,
                                      fontWeight: style.isBold
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
      ),
    );
  }
}
