import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:riwaa/core/utilities/constants.dart';

class CustomToggleSwitch extends StatefulWidget {
  final String optionOne;
  final String optionTwo;
  final bool initialValue;
  final Function(bool) onChanged;
  final Color activeColor;

  const CustomToggleSwitch({
    super.key,
    required this.optionOne,
    required this.optionTwo,
    required this.initialValue,
    required this.onChanged,
    this.activeColor = kPrimaryColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            widget.optionOne,
            style: TextStyle(
              fontWeight: !_value ? FontWeight.bold : FontWeight.normal,
              color: !_value ? widget.activeColor : Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CupertinoSwitch(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });
              widget.onChanged(newValue);
            },
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            widget.optionTwo,
            style: TextStyle(
              fontWeight: _value ? FontWeight.bold : FontWeight.normal,
              color: _value ? widget.activeColor : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}