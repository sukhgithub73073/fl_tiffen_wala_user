part of 'image_pick_bloc.dart';

sealed class ImagePickEvent extends Equatable {
  const ImagePickEvent();
}

class ChangeImagePickEvent extends ImagePickEvent {
  final int index ;
  const ChangeImagePickEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
