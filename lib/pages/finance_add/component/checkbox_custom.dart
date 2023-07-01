import 'package:flutter/material.dart';

class CkechBoxCustom extends StatefulWidget {
  const CkechBoxCustom({super.key, required this.checkbox});

  final Function(bool) checkbox;

  @override
  State<CkechBoxCustom> createState() => _CkechBoxCustomState();
}

class _CkechBoxCustomState extends State<CkechBoxCustom> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 05.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.checkbox(isChecked);
              });
            },
          ),
          const Expanded(
            flex: 2,
            child: Text(
              "Repetir finança.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
