import 'package:http/http.dart';
import 'dart:convert';

void main() {
  requestData();
  requestDataAsync();
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";

// Future de response, onde o get mostra todos os metadados da url
  Future<Response> futureResponse = get(Uri.parse(url));
//   do resultado, mostra apenas o body, todo o json, sem filters
  futureResponse.then((Response response) {
    print(response.body);

    // converte o json em string, mapeia como chave, valor, fazer a pesquisa atraves de uma função anonima com a pesquisa e retorna o valor de balance da Carka
    List<dynamic> listsAccount = json.decode(response.body);
    Map<String, dynamic> mapCarla = listsAccount.firstWhere((element) => element["name"] == "Elisa",);
    print(mapCarla["balance"]);

  },);

}


void requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";
  Response response = await get(Uri.parse(url));
  print(json.decode(response.body)[0]);
  print("ultima linha despois de aguardar a função async");

}