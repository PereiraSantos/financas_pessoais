import 'package:flutter/material.dart';

class MessageUser extends StatefulWidget {
  const MessageUser({super.key});

  @override
  State<MessageUser> createState() => _MessageUserState();
}

class _MessageUserState extends State<MessageUser> {
  bool reload = true;

  bool isVisible() {
    if (reload) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            reload = false;
          });
        }
      });

      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible(),
      child: const Padding(
        padding: EdgeInsets.only(left: 15.0, top: 5),
        child: Text(
            'Ao criar uma nova finança as despesas serão vinculada a essa finança.'),
      ),
    );
  }
}
