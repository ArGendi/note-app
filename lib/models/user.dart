class User{
  String? email;
  String? password;

  User({this.email, this.password});

  Map<String, dynamic> toMap(){
    return {
      "email" : email, // abdo@gmail.com
      "password" : password, // 123456
    };
  }
}