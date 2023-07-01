import 'package:flutter/material.dart';

import '../../../entities/category/category.dart';
import '../../../entities/finance/finance.dart';
import '../../../usercase/format_date.dart';
import '../../outgoing_list/outigoing_list_controller/outgoing_list_controller.dart';
import '../controller/outgoing_add_controller.dart';

// ignore: must_be_immutable
class DropdownButtonFinance extends StatefulWidget {
  DropdownButtonFinance({
    super.key,
    required this.outgoingAddController,
  });

  OutgoingAddController outgoingAddController;

  @override
  State<DropdownButtonFinance> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonFinance> {
  Finance? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
      child: DropdownButton<Finance>(
        value: dropdownValue ?? widget.outgoingAddController.finance[0],
        elevation: 16,
        isDense: true,
        isExpanded: true,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
        onChanged: (dynamic value) {
          widget.outgoingAddController.setFinance(value.id);
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.outgoingAddController.finance
            .map<DropdownMenuItem<Finance>>((dynamic value) {
          return DropdownMenuItem<Finance>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(value.value.toString())),
                Expanded(
                    child: Text(
                  Format.formatDateDayMonth(value.dateStart),
                  textAlign: TextAlign.right,
                )),
                Expanded(
                  child: Text(
                      ' a ${Format.formatDateDayMonth(value.dateFinish ?? Format.formatDate(DateTime.now()))}'),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
