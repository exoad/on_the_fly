import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:on_the_fly/shared/app.dart';
import 'package:on_the_fly/shared/theme.dart';

class SpinnerChip<T> {
  final String title;
  final Widget? icon;
  final T obj;
  const SpinnerChip({required this.title, this.icon, required this.obj});

  @pragma("vm:prefer-inline")
  static List<SpinnerChip<E>> fromRelated<E>(Iterable<(String title, E item)> items,
      [Widget? icon]) {
    List<SpinnerChip<E>> e = <SpinnerChip<E>>[];
    for ((String title, E item) i in items) {
      e.add(SpinnerChip<E>(title: i.$1, obj: i.$2, icon: icon));
    }
    return e;
  }
}

class JobSimpleSpinner<T> extends StatefulWidget {
  final Widget? leadingIcon;
  final String? hint;
  final List<SpinnerChip<T>> chips;
  final void Function(T? chip) onSelect;

  const JobSimpleSpinner(
      {super.key,
      required this.chips,
      required this.onSelect,
      this.leadingIcon,
      this.hint});

  @override
  State<JobSimpleSpinner<T>> createState() => _JobSimpleSpinnerState<T>();
}

class _JobSimpleSpinnerState<T> extends State<JobSimpleSpinner<T>> {
  T? _selected;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
        hint: widget.hint != null
            ? Text(widget.hint!,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
            : null,
        value: _selected,
        underline: const SizedBox(),
        menuItemStyleData: const MenuItemStyleData(
            height: 38, padding: EdgeInsets.symmetric(horizontal: 4)),
        dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsets.all(0),
            scrollPadding: const EdgeInsets.all(0),
            isOverButton: true,
            decoration: BoxDecoration(
                border: Border.all(color: kTheme2, width: 2),
                color: kThemeBg,
                borderRadius: BorderRadius.circular(kRRArc))),
        buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(color: kTheme2, width: 2),
                borderRadius: BorderRadius.circular(kRRArc))),
        items: <DropdownMenuItem<T>>[
          for (SpinnerChip<T> chip in widget.chips)
            DropdownMenuItem<T>(
                value: chip.obj,
                child: Row(children: <Widget>[
                  if (chip.icon != null)
                    chip.icon!, // this bang operator is so fucking retarded
                  if (chip.icon != null) const SizedBox(width: 4),
                  Text(chip.title)
                ]))
        ],
        onChanged: (T? value) {
          logger.info("SELECTED $value");
          setState(() => _selected = value);
          widget.onSelect(_selected);
        });
  }
}
