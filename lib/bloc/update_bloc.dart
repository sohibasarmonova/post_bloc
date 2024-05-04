import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:post_bloc/bloc/update_event.dart';
import 'package:post_bloc/bloc/update_state.dart';


import '../models/post_model.dart';
import '../services/http_service.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  UpdateBloc() : super(UpdateInitialState()) {
    on<UpdatePostEvent>(_onUpdatePostEvent);
  }

  Future<void> _onUpdatePostEvent(UpdatePostEvent event, Emitter<UpdateState> emit) async {
    emit(UpdateLoadingState());

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post newPost = event.post;
    newPost.title = title;
    newPost.body = body;

    var response = await Network.PUT(Network.API_POST_UPDATE + newPost.id.toString(), Network.paramsUpdate(newPost));
    // LogService.d(response!);
    if(response != null){
      emit(UpdatedPostState(newPost));
    } else {
      emit(const UpdateErrorState('Could not delete post'));
    }
  }
}