import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/controllers/home/home_controller.dart';
import 'package:revision/controllers/home/home_state.dart';
import 'package:revision/widgets/custom_button.dart';
import 'package:revision/widgets/custom_textfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _showMyDialog(int index) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Note access'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Tell me password of this note'),
              Text('To Delete it'),
              TextField(
                controller: HomeControllerCubit.get(context).passwordController,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              HomeControllerCubit.get(context).deleteNoteByPassword(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeControllerCubit.get(context).getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes",),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<HomeControllerCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.separated(
                  itemBuilder: (context, i){
            return InkWell(
              onDoubleTap: (){
                if(HomeControllerCubit.get(context).notes[i].password!.isNotEmpty){
                  _showMyDialog(i);
                }
                else HomeControllerCubit.get(context).deleteNote(i);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HomeControllerCubit.get(context).notes[i].title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        HomeControllerCubit.get(context).notes[i].content.toString(),
                      ),
                    ],
                  ),
                  if(HomeControllerCubit.get(context).notes[i].password!.isNotEmpty)
                    Icon(Icons.lock_outline, color: Colors.black,)
                ],
              ),
            );
                  },
                  separatorBuilder: (context, i){
            return SizedBox(height: 10,);
                  },
                  itemCount: HomeControllerCubit.get(context).notes.length,
                ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context){
              return Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  top: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: HomeControllerCubit.get(context).formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        text: "Title",
                        onSaved: (value){
                          HomeControllerCubit.get(context).note.title = value;
                        }, 
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      CustomTextField(
                        text: "Your note",
                        onSaved: (value){
                          HomeControllerCubit.get(context).note.content = value;
                        }, 
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your note';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      CustomTextField(
                        text: "Password",
                        onSaved: (value){
                          HomeControllerCubit.get(context).note.password = value;
                        }, 
                        validator: (value){
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      CustomButton(
                        text: 'Add your note', 
                        onClick: () async{
                          HomeControllerCubit.get(context).onAddNote();
                        },
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}