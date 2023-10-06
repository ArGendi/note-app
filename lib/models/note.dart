class Note{
  int? id;
  String? title;
  String? content;
  String? password;

  Note({this.id, this.title, this.content, this.password});
  Note.fromMap(Map<String, dynamic> map){
    id = map['id'];
    title = map['title'];
    content = map['content'];
    password = map['password'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'content': content,
      'password': password,
    };
  }
}