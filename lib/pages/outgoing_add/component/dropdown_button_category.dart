import 'package:flutter/material.dart';

import '../../../entities/category/category.dart';
import '../controller/outgoing_add_controller.dart';

// ignore: must_be_immutable
class DropdownButtoncategory extends StatefulWidget {
  DropdownButtoncategory({
    super.key,
    required this.outgoingAddController,
  });

  OutgoingAddController outgoingAddController;

  @override
  State<DropdownButtoncategory> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtoncategory> {
  Category? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
      child: DropdownButton<Category>(
        value: dropdownValue ?? widget.outgoingAddController.category[0],
        elevation: 16,
        isDense: true,
        isExpanded: true,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        onChanged: (dynamic value) {
          widget.outgoingAddController.setColor(value.id);
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.outgoingAddController.category
            .map<DropdownMenuItem<Category>>((dynamic value) {
          return DropdownMenuItem<Category>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: Text(value.description!)),
                Expanded(
                    child: Text(
                  value.emoji ?? '',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.right,
                )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
