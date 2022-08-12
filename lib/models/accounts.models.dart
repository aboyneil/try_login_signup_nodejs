List<AccountModel> accountsFromJson(dynamic str) =>
    List<AccountModel>.from((str).map((x) => AccountModel.fromJson(x)));

class AccountModel {
  late String? id;
  late String? name;
  late String? username;
  late String? email;
  late String? mobileNumber;
  late String? password;

  AccountModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.mobileNumber,
      this.password});

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    mobileNumber = json["mobileNumber"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["name"] = name;
    _data["username"] = username;
    _data["email"] = email;
    _data["mobileNumber"] = mobileNumber;
    _data["password"] = password;

    return _data;
  }
}
