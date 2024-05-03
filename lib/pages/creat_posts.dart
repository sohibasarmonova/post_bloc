import 'package:flutter/material.dart';
import 'package:post_bloc/models/post_model.dart';
import 'package:post_bloc/models/post_res_model.dart';


import '../services/http_service.dart';
import '../services/log_service.dart';

class CreatPage extends StatefulWidget {
  const CreatPage({super.key});

  @override
  State<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  _creatPost() async{
    String title = _titleController.text.toString().trim();
    String body = _bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);
    PostRes postRes = Network.parsePostRes(response);
    backToFinish();
  }

  backToFinish(){
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Creat Post"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: "Title"
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: _bodyController,
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
                    _creatPost();
                  },
                  child: Text("Creat"),
                )
            ),
          ],
        ),
      ),
    );
  }
}