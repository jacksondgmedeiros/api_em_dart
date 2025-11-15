import 'package:http/http.dart';
import 'dart:convert';

void main() {
  requestData();
}

requestData() {
  String url =
      "https://gist.githubusercontent.com/jacksondgmedeiros/d8fe863d121c830c943b67dd5c295d52/raw/812cf69296ec730c0b31878871fd805d1bbefc44/accounts.json";

  Future<Response> futureResponse = get(Uri.parse(url));
  futureResponse.then((Response response) {
    print(response.body);
    List<dynamic> listsAccount = json.decode(response.body);
    Map<String, dynamic> mapCarla = listsAccount.firstWhere((element) => element["name"] == "Carla",);
    print(mapCarla["balance"]);

  },);

}
