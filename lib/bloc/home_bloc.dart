import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc/bloc/create_bloc.dart';
import 'package:post_bloc/bloc/home_evant.dart';
import 'package:post_bloc/bloc/update_bloc.dart';
import 'package:post_bloc/models/post_model.dart';
import 'package:post_bloc/pages/creat_posts.dart';
import 'package:post_bloc/pages/update_post_page.dart';
import 'package:post_bloc/services/http_service.dart';

import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isLoading = true;
  List<Post> posts = [];

  HomeBloc() : super(HomeInitialState()) {
    on<LoadPostListEvent>(_onLoadPostListEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
  }

  Future<void> _onDeletePostEvent(DeletePostEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    var response = await Network.DEL(
        Network.API_POST_DELETE + event.post.id.toString(),
        Network.paramsEmpty());
    if (response != null) {
      emit(HomeDeletePostState());
    } else {
      emit(HomeErrorState('Could not delete post'));
    }
  }

  Future<void> _onLoadPostListEvent(
      LoadPostListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    var response =
    await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    if (response != null) {
      var postList = Network.parsePostList(response);
      posts.addAll(postList);
      emit(HomePostListState(posts));
    } else {
      emit(HomeErrorState("Could not fetch posts"));
    }
  }
  Future callCreatePage(BuildContext context) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => CreateBloc(),
            child: CreatPage(),
          );
        },
      ),
    );

    if (result) {
      add(LoadPostListEvent());
    }
  }

  Future callUpdatePage(BuildContext context, Post post) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => UpdateBloc(),
            child: UpdatePage(post: post),
          );
        },
      ),
    );

    if (result) {
      add(LoadPostListEvent());
    }
  }
}


