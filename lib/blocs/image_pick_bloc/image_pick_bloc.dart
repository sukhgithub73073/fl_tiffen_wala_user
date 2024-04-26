import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';

part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitial()) {
    on<ChangeImagePickEvent>(_onImageChange);
  }

  Future<FutureOr<void>> _onImageChange(
      ChangeImagePickEvent event, Emitter<ImagePickState> emit) async {
    var file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 400,
        maxHeight: 400);
    emit(ImagePickLoading());
    if (file != null) {
      emit(ImagePickSuccess(file: file));
    } else {
      emit(ImagePickError(error: "Please pick any image"));
    }
  }
}
