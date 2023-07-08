import 'package:financas_pessoais/entities/outgoing/outgoing.dart';
import 'package:web_scraper/web_scraper.dart';

import 'format_date.dart';

class QrCode {
  static Future<List<Outgoing>> readQrCode(String url) async {
    List<Outgoing> list = [];

    final webScraper = WebScraper('http://www.fazenda.pr.gov.br');
    if (await webScraper.loadWebPage(
        url.toString().replaceAll("http://www.fazenda.pr.gov.br", ""))) {
      List<Map<String, dynamic>> elements =
          webScraper.getElement('tr > td > span.txtTit2', ['class']);

      List<Map<String, dynamic>> elementsValue =
          webScraper.getElement('tr > td > span.valor', ['class']);

      List<String> listProduct = [];
      List<double> listProductValue = [];

      for (var i = 0; i < elements.length; i++) {
        elements[i].forEach((key, value) {
          if (key == "title") {
            listProduct.add(value);
          }
        });
      }

      for (var i = 0; i < elementsValue.length; i++) {
        elementsValue[i].forEach((key, value) {
          if (key == "title") {
            listProductValue
                .add(double.parse(value.toString().replaceAll(",", '.')));
          }
        });
      }

      for (var i = 0; i < listProduct.length; i++) {
        list.add(
          Outgoing(
            description: listProduct[i],
            value: listProductValue[i],
            date: Format.formatDate(DateTime.now()),
          ),
        );
      }
    }

    return Future.value(list);
  }
}
