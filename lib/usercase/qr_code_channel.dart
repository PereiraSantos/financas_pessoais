import 'package:flutter/services.dart';


class QrCodeChannel {

  final qrChannel = const MethodChannel('qrCode');

  Future<String> readQrCode() async {
    String? result = await qrChannel.invokeMethod<String>('readCode');
    return result!;
  }
}