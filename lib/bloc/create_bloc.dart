import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:post_bloc/bloc/create_event.dart';
import 'package:post_bloc/bloc/create_state.dart';
import 'package:post_bloc/models/post_model.dart';
import 'package:post_bloc/services/http_service.dart';

class CreateBloc extends Bloc<CreateEvent,CreateState>{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();


  CreateBloc() : super(CreateInitialState()) {
    on<CreatePostEvent>(_onCreatePostEvent);
  }
  Future<void> _onCreatePostEvent(CreatePostEvent event,
      Emitter<CreateState> emit) async {
    emit(CreateLoadingState());



    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    if(response != null){
      emit(CreatedPostState(post));
    } else {
      emit(CreateErrorState('Could not delete post'));
    }
  }
}