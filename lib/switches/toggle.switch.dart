import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch(
      {Key? key,
      this.color,
      required this.options,
      required this.onChange,
      required this.index,
      this.nullableValue,
      this.height,
      this.width})
      : super(key: key);
  final Color? color;
  final List<String> options;
  final int? index;
  final Function(int? index) onChange;
  final String? nullableValue;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    double height = this.height ?? 72;
    double width = this.width ?? 200;
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(
          color: Color(0xFFE9E9EA),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          )),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (nullableValue != null)
            InkWell(
              onTap: () => onChange(null),
              child: AnimatedContainer(
                height: height - 6,
                width: width / 2 - 162,
                decoration: BoxDecoration(
                    color: index == null ? Colors.grey : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    )),
                margin: const EdgeInsets.only(right: 6.0),
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear,
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(6.0),
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
                height: height - 6,
                width: width / 2 - 6,
                decoration: BoxDecoration(
                    color: index == i ? color : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    )),
                margin: const EdgeInsets.only(right: 0.0),
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear,
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      options[i],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: index == i ? Colors.white : null,
                          fontSize: 14),
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
