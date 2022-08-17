import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:try_login_signup_nodejs/models/accounts.models.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:dio/dio.dart';

class APIService {
  static var client = http.Client();

  static Future<List<AccountModel>?> getProducts() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.productURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return accountsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future newSaveProduct(AccountModel model, BuildContext context) async {
    Dio dio = Dio();
    var productURL = Config.productURL;
    var url = Uri.http(Config.apiURL, productURL);
    try {
      return await dio.post(
        url.toString(),
        data: {
          "name": model.name,
          "username": model.username,
          "email": model.email,
          "mobileNumber": model.mobileNumber,
          "password": model.password,
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
    } on DioError catch (e) {
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        e.response!.data['message'],
        "Ok",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  static Future saveProduct(
    AccountModel model,
  ) async {
    var productURL = Config.productURL;

    // if (isEditMode) {
    //   productURL = productURL + "/" + model.id.toString();
    // }

    var url = Uri.http(Config.apiURL, productURL);

    // var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest("POST", url);
    request.fields["name"] = model.name!;
    request.fields["username"] = model.username!;
    request.fields["email"] = model.email!;
    request.fields["mobileNumber"] = model.mobileNumber!;
    request.fields["password"] = model.password!;

    // if (model.productImage != null && isFileSelected) {
    //   http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
    //     'productImage',
    //     model.productImage!,
    //   );

    //   request.files.add(multipartFile);
    // }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.productURL + "/" + productId);

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
