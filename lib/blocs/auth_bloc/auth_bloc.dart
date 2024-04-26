import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:tiffen_wala_user/common/models/user.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/repositiries/auth_repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var authRepository = GetIt.I<AuthRepository>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<RequestOtpAuthEvent>(_requestOtp);
    on<OtpVerificationAuthEvent>(_verificationOtp);
  }

  Future<FutureOr<void>> _requestOtp(
      RequestOtpAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    var doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc("yEin9FOzrzrcQrRdH0ty")
        .get();

    if (doc.exists) {
      var userModel = UserModel(
        name: doc['name'],
        email: doc['email'],
        address: doc['address'],
        phone: doc['phone'],
        profileImage: doc['profileImage'],
        uid: doc['uid'],
      );
      emit(AuthSuccess(userModel: userModel));
    }else{
      emit(AuthError(error: "Not Found")) ;
    }
  }

  Future<FutureOr<void>> _verificationOtp(
      OtpVerificationAuthEvent event, Emitter<AuthState> emit) async {
    try {
      var userModel = UserModel(
          name: "",
          email: "",
          address: "",
          uid: "",
          phone: "",
          profileImage: "");

      emit(AuthLoading());
      var model = await authRepository.otpVerificationApi(event.map);
      if (model.status == "success") {
        User user = model.data!;
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (!snapshot.exists) {
          var mapss = {
            "name": user.displayName,
            "address": "",
            "email": user.email,
            "phone": user.phoneNumber,
            "profileImage": user.photoURL,
            "uid": user.uid
          };
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(mapss);
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((doc) {
          if (doc.exists) {
            userModel = UserModel(
              name: doc['name'],
              email: doc['email'],
              address: doc['address'],
              phone: doc['phone'],
              profileImage: doc['profileImage'],
              uid: doc['uid'],
            );
            // Do something with the userModel
          }
        });
        emit(AuthSuccess(userModel: userModel));
      } else {
        emit(AuthError(error: model.message));
      }
    } catch (e) {
      emit(AuthError(error: "$e"));
    }
  }
}
