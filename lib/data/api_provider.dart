import 'dart:convert';
import 'package:bloc_test/data/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  // add the adding get the todo list

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    print("getting User List.....");
    List<User> usersList = [];
    print("connect to internet");
    http.Response response =
        await http.get(Uri.parse('https://gorest.co.in/public/v2/users'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      for (var json in body) {
        print(json);
        usersList.add(User.fromJson(json));
      }
      return usersList;
    }
    return [];
  }

  Future<void> postUser({
    required BuildContext context,
    required String name,
    required String email,
    required String gender,
  }) async {
    Uri url = Uri.parse('https://gorest.co.in/public/v2/users');
    String accessToken =
        "ed0645c09baf75ccb7b21afc0af41ab01f0770fd90e831d5295fab6c77d96965";
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "name": name,
          "gender": gender,
          "email": email,
          "status": "active",
        },
      ),
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error with ${response.reasonPhrase}'),
        ),
      );
    }
  }
}
