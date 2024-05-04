import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc/bloc/create_bloc.dart';
import 'package:post_bloc/bloc/create_event.dart';
import 'package:post_bloc/bloc/create_state.dart';


class CreatPage extends StatefulWidget {
  const CreatPage({super.key});

  @override
  State<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {

  late  CreateBloc createBloc;


  backToFinish(){
    Navigator.of(context).pop(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBloc = BlocProvider.of(context);
    createBloc.stream.listen((state) {
      if (state is CreatedPostState) {
        backToFinish();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Creat Post"),
      ),
      body: BlocBuilder<CreateBloc, CreateState>(
        builder: (context, state) {
          if (state is CreateErrorState) {
            return viewOfError(state.errorMessage);
          }

          if (state is CreateLoadingState) {
            return viewOfLoading();
          }

          return viewOfNewPost();
        },
      ),
    );
  }

  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget viewOfNewPost() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: createBloc.titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: createBloc.bodyController,
            decoration: const InputDecoration(hintText: "Body"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                String title = createBloc.titleController.text.toString().trim();
                String body = createBloc.bodyController.text.toString().trim();

                createBloc.add(CreatePostEvent(title, body));
              },
              child: const Text("Create"),
            ),
          ),
        ],
      ),
    );
  }
}


