import 'dart:convert';

import 'package:http/http.dart';
import 'package:revision/models/user.dart';

class WebServices{

  Future<Map<String, dynamic>?> login(User user) async{
    Response response = await post(
      Uri.parse("https://project1.amit-learning.com/api/auth/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(user.toMap())
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      return null;
    }
  }

}
