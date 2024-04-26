import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';
import 'package:tiffen_wala_user/common/models/response_model.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';

abstract class AuthRepository {
  Future<ResponseModel> requestOtpApi(Map<String, dynamic> map);

  Future<ResponseModel> otpVerificationApi(Map<String, dynamic> map);
}

class AuthRepositoryImp extends AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<ResponseModel> requestOtpApi(Map<String, dynamic> map) async {
    ResponseModel responseModel = ResponseModel();
    try {
       auth
          .verifyPhoneNumber(
              phoneNumber: "+91${map["mobile"]}",
              verificationCompleted: (credential) {
                print("requestOtpApi>>>>>>>>>>verificationCompleted");
              },
              verificationFailed: (e) {
                print("requestOtpApi>>>>>>>>>>verificationFailed$e");
                responseModel.status = "error";
                responseModel.message = "$e";
              },
              codeSent: (verificationId, forceResendingToken) {
                print("requestOtpApi>>>>>>>>>>codeSent");

                responseModel.status = "success";
                responseModel.message =
                    "Otp will be send on your mobile number";

                responseModel.data = {"verificationId": verificationId};
              },
              codeAutoRetrievalTimeout: (e) {
                print("requestOtpApi>>>>>>>>>>codeAutoRetrievalTimeout$e");

                responseModel.status = "error";
                responseModel.message = "$e";
              });


    } catch (e, t) {
      responseModel.status = "error";
      responseModel.message = "$e";
      "$e $t".printLog(msg: "requestOtpApi>>>>>>>>>>>>>>>>");
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> otpVerificationApi(Map<String, dynamic> map) async {
    ResponseModel responseModel = ResponseModel();
    var _credential = await PhoneAuthProvider.credential(
        verificationId: map["verificationId"], smsCode: map["otp"]);
    await auth.signInWithCredential(_credential).then((value) {
      responseModel.status = "success";
      responseModel.message = "Successfully login";
      responseModel.data = value.user;
    }).catchError((e) {
      responseModel.status = "error";
      responseModel.message = "$e";
    });
    return responseModel;
  }
}
