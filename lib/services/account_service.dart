import 'dart:async';

import 'package:api_em_dart/api-key.dart';
import 'package:api_em_dart/models/account.dart';
import 'package:http/http.dart';
import 'dart:convert';

class AccountService{


// controlador de streams, operações automaticas, como se fosse ao vivo
final StreamController<String> _streamController = StreamController<String>();

// para a stream ter acesso por fora da service
Stream<String> get streamInfos => _streamController.stream;

String url = "https://api.github.com/gists/d8fe863d121c830c943b67dd5c295d52";

  // void requestData() {
  //exemplos com print para mostrar na tela e ficar mais fácil o entendimento
  // String url =
  //     "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";

  // // Future de response, onde o get mostra todos os metadados da url
  // Future<Response> futureResponse = get(Uri.parse(url));
  // //   do resultado, mostra apenas o body, todo o json, sem filters
  // futureResponse.then((Response response) {
  //   print(response.body);

  //   // converte o json em string, mapeia como chave, valor, fazer a pesquisa atraves de uma função anonima com a pesquisa e retorna o valor de balance da Carka
  //   List<dynamic> listsAccount = json.decode(response.body);
  //   Map<String, dynamic> mapCarla = listsAccount.firstWhere(
  //     (element) => element["name"] == "Elisa",
  //   );
  //   print(mapCarla["balance"]);
  // });

//   String url =
//       "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";

//   // Future de response, onde o get mostra todos os metadados da url
//   Future<Response> futureResponse = get(Uri.parse(url));
//   //   do resultado, mostra apenas o body, todo o json, sem filters
//   futureResponse.then((Response response) {
//     streamController.add("${DateTime.now()} | Requisição de leitura usando then.");
//   });
// }
// }



Future<List<Account>>  getAll() async {
  Response response = await get(Uri.parse(url));
    _streamController.add("${DateTime.now()} | Requisição de leitura.");

   Map<String, dynamic> mapResponse = json.decode(response.body);

   List<dynamic> listDynamic =
        json.decode(mapResponse["files"]["accounts.json"]["content"]);

  List<Account> listAccounts = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccounts.add(account);
    }

    return listAccounts;
  
}

Future<void> addAccount(Account account) async {
  List<Account> listsAccount = await getAll();
  listsAccount.add(account);
  
  List<Map<String, dynamic>> listContent = [];
    for (Account account in listsAccount) {
      listContent.add(account.toMap());
    }


    String content = json.encode(listContent);

  
  Response response = await post(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $gitHubKey"},
    body: json.encode({
      "description": "accounts.json",
      "public": true,
      "files": {
        "accounts.json": {"content": content},
      },
    }),
  );

  if(response.statusCode.toString()[0] == "2"){
    
    _streamController.add("${DateTime.now()} | Requisição de adição bem sucessida. (${account.name})");
  }else{
    _streamController.add("${DateTime.now()} | Requisição de de adição falhou (${account.name})");

  }
}

}