import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch(
      {Key? key,
      this.color,
      required this.options,
      required this.onChange,
      required this.index, this.nullableValue})
      : super(key: key);
  final Color? color;
  final List<String> options;
  final int? index;
  final Function(int? index) onChange;
  final String? nullableValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: const BoxDecoration(
          color: Color(0xFFE9E9EA),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(nullableValue != null)
            InkWell(
              onTap: () => onChange(null),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: index == null ? Colors.grey : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                margin: const EdgeInsets.only(right: 5.0),
                duration: const Duration(milliseconds: 50),
                curve: Curves.linear,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      nullableValue!,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: index == null ? Colors.white : null,
                          fontSize: 16),
                    )),
              ),
            ),
          for (int i = 0; i < options.length; i++)
            InkWell(
              onTap: () => onChange(i),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: index == i ? color : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    )),
                margin: const EdgeInsets.only(right: 5.0),
                duration: const Duration(milliseconds: 50),
                curve: Curves.linear,
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      options[i],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: index == i ? Colors.white : null,
                          fontSize: 16),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
