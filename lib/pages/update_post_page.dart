import 'package:flutter/material.dart';
import 'package:post_bloc/bloc/update_bloc.dart';
import 'package:post_bloc/bloc/update_event.dart';
import 'package:post_bloc/bloc/update_state.dart';
import 'package:post_bloc/models/post_model.dart';
import 'package:post_bloc/services/log_service.dart';


class UpdatePage extends StatefulWidget {
 final Post post;
  const UpdatePage({super.key,required this.post});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  UpdateBloc updateBloc= UpdateBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBloc.titleController.text=widget.post.title!;
    updateBloc.bodyController.text=widget.post.body!;

    updateBloc.stream.listen((state) {
      if (state is UpdatedPostState) {
        LogService.d('UpdatedPostState is done');
        backToFinish();
      }
    });
  }

  backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    // keyvord ekran hohlagan joyini bossa yo'qolad
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Update Post"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: updateBloc.titleController,
                  decoration: InputDecoration(
                      hintText: "Title"
                  ),
                ),
              ),
              Container(
                child: TextField(
                  controller: updateBloc.bodyController,
                  decoration: InputDecoration(
                      hintText: "Body"
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      updateBloc.add(UpdatePostEvent(widget.post));
                    },
                    child: Text("Update"),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
