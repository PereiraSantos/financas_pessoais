import 'package:flutter/material.dart';

import '../../../entities/outgoing/outgoing.dart';
import '../../../usercase/format_date.dart';

// ignore: must_be_immutable
class AddOutgoinQrCode extends StatelessWidget {
  AddOutgoinQrCode({super.key, required this.listOutgoing}) {
    listOutgoing.length == 1;
  }

  List<Outgoing> listOutgoing = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOutgoing.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Card(
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 1),
                  child: Text(
                    'DESCRIÇÂO: ${listOutgoing[index].description}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 4, bottom: 1),
                  child: Text(
                    'R\$ ${Format.currentFormat(listOutgoing[index].value!)}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
