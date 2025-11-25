import 'dart:io';

import 'package:api_em_dart/models/account.dart';
import 'package:api_em_dart/services/account_service.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((infoString) {
      print(infoString);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - 👀 Ver todas sua contas.");
      print("2 - ➕ Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Te vejo na próxima. 👋");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente.");
            }
        }
      }
    }
  }

  Future<void> _addExampleAccount() async {
    Account example = Account(
      id: "ID555",
      name: "Joaquim",
      lastName: "Medeiros",
      balance: 800.1,
    );

    await _accountService.addAccount(example);
  }

  Future<void> _getAllAccounts() async {
    List<Account> listAccounts = await _accountService.getAll();
    print(listAccounts);
  }
}
