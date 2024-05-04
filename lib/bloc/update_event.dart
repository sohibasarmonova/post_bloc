import 'package:equatable/equatable.dart';
import 'package:post_bloc/models/post_model.dart';

abstract class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePostEvent extends UpdateEvent {
  final Post post;

  const UpdatePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}