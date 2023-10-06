import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/home/home_state.dart';
import 'package:revision/local/offline_database.dart';
import 'package:revision/models/note.dart';

class HomeControllerCubit extends Cubit<HomeState>{
  Note note = Note();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Note> notes = [];
  TextEditingController passwordController = TextEditingController();

  HomeControllerCubit() : super(InitHomeState());
  static HomeControllerCubit get(context) => BlocProvider.of(context);

  Future<void> onAddNote() async{
    bool valid = formKey.currentState!.validate();
    if(valid){
      formKey.currentState!.save();
      MyDataBase myDB = MyDataBase();
      Note newNote = Note(
        id: notes.length+1,
        title: note.title,
        content: note.content,
        password: note.password
      );
      await myDB.insertNoteInDB(newNote);
      notes.add(newNote);
      formKey.currentState!.reset();
      emit(AddNoteHomeState());
    }
  }

  void getDataFromDB() async{
    if(notes.isEmpty){
      emit(LoadingHomeState());
      MyDataBase myDB = MyDataBase();
      notes = await myDB.getNotesFromDB();
      emit(SuccessHomeState());
    }
  }

  void deleteNoteByPassword(int noteIndex){
    if(notes[noteIndex].password == passwordController.text){
      notes.removeAt(noteIndex);
      passwordController.clear;
      emit(DeleteNoteHomeState());
    }
  }

  void deleteNote(int noteIndex){
    notes.removeAt(noteIndex);
    emit(DeleteNoteHomeState());
  }
}