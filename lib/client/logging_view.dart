import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:logging/logging.dart';
import 'package:on_the_fly/client/components/components.dart';
import 'package:on_the_fly/client/events/ephemeral_stacks.dart';
import 'package:on_the_fly/helpers/color_helper.dart';
import 'package:on_the_fly/shared/theme.dart';
import 'package:provider/provider.dart';

class LoggingView extends StatefulWidget {
  const LoggingView({super.key});

  @override
  State<LoggingView> createState() => _LoggingViewState();
}

class _LogActionButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color color;
  final void Function() action;

  const _LogActionButton(
      {required this.action,
      this.icon,
      required this.label,
      // ignore: unused_element
      this.color = kThemePrimaryFg1});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 4)),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRRArc))),
            visualDensity: VisualDensity.compact,
            backgroundColor: WidgetStatePropertyAll<Color>(color)),
        onPressed: action,
        child: Row(children: <Widget>[
          if (icon != null) Icon(icon),
          if (icon != null) const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))
        ]));
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
    _repaint = () => setState(() {});
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
              action: () => setState(_logHistory.clear),
              label: Provider.of<InternationalizationNotifier>(context)
                  .i18n
                  .loggerView
                  .clear),
        ],
      ),
      child: Expanded(
        child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: _logHistory.length,
            itemBuilder: (BuildContext context, int index) {
              LogStyle style = loggingColors(_logHistory[index].level);
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: IntrinsicHeight(
                  // to make vertical divider show up, thanks to https://stackoverflow.com/a/49388387
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(width: 26),
                      child: Center(
                        child: Text("${index + 1}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.black.bipartiteContrast())),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(width: 200),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRRArc),
                            border: Border.all(color: style.color, width: 1.5)),
                        child: Center(
                          child: Text(
                              _logHistory[index].time.toString().replaceAll("\n", ""),
                              style: TextStyle(
                                color: style.color,
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(width: 60),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Text(_logHistory[index].message,
                            softWrap: true,
                            style: TextStyle(
                                color: style.color,
                                fontSize: 12,
                                fontWeight:
                                    style.isBold ? FontWeight.bold : FontWeight.normal)),
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
