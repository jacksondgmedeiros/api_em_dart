import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });

  // um construtor a partir do original que consegue inicializar para transformar em um Map
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      lastName: map["lastName"],
      balance: map["balance"],
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
    "id": id,
    "name": name ,
    "lastName": lastName ,
    "balance": balance ,
    };
  }

  

  Account copyWith({
  String? id,
  String? name,
  String? lastName,
  double? balance,
}) {
  return Account(
    id: id ?? this.id,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    balance: balance ?? this.balance,
  );
}

String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

@override
String toString() {
  return 'Conta $id: $name $lastName, Saldo: $balance';
}

@override
bool operator ==(Object other) {
  if (identical(this, other)) return true;

  return other is Account &&
      other.id == id &&
      other.name == name &&
      other.lastName == lastName &&
      other.balance == balance;
}

@override
int get hashCode {
  return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
}
}
