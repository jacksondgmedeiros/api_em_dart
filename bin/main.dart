
import 'package:api_em_dart/screens/account_screen.dart';

void main() {

AccountScreen accountScreen =AccountScreen();

accountScreen.initializeStream();
accountScreen.runChatBot();

  // basicamente inicia a live ao vivo, e estamos ouvindo, mas falta alguém mandar os dados
  // StreamSubscription streamSubscription = streamController.stream.listen((
  //   String info,
  // ) {
  //   print(info);
  // });

  // requestData();
  // requestDataAsync();
  // senDataAsync({
  //   "id": "NEW001",
  //   "name": "Joao",
  //   "lastName": "Medeiros",
  //   "balance": 500,
  // });

}

