import 'package:api_em_dart/api-key.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  requestData();
  requestDataAsync();
  senDataAsync({
    "id": "NEW001",
    "name": "Joao",
    "lastName": "Medeiros",
    "balance": 500,
  });
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
    Map<String, dynamic> mapCarla = listsAccount.firstWhere(
      (element) => element["name"] == "Elisa",
    );
    print(mapCarla["balance"]);
  });
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";
  Response response = await get(Uri.parse(url));
  return json.decode(response.body);
}

void senDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listsAccount = await requestDataAsync();
  listsAccount.add(mapAccount);
  String content = json.encode(listsAccount);

  String url = "https://api.github.com/gists/d8fe863d121c830c943b67dd5c295d52";
  Response response = await post(
    Uri.parse(url),
    headers: {
      "Authorization" : "Bearer $gitHubKey"
    },
    body: json.encode({
      "description": "accounts.json",
      "public": true,
      "files":{
        "accounts.json":{
          "content": content,
        }
      }
    }),
    );

  print(response.statusCode);
}
