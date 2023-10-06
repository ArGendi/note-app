import 'package:path/path.dart';
import 'package:revision/models/note.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase{

  Future<Database> openDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'revision.db'),
      version: 1,
      onCreate: (db, version){
        db.execute("CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, password TEXT)");
      }
    );
  }

  Future<void> insertNoteInDB(Note note) async{
    Database db = await openDB();
    await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotesFromDB() async{
    Database db = await openDB();
    List<Map<String, dynamic>> data = await db.query('notes');
    List<Note> notes = data.map((e) => Note.fromMap(e)).toList();
    return notes;
  }

  
}


