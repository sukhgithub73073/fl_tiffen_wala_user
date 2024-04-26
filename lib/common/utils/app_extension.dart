import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
bool _logEnable = true;
extension NavigatorContext on BuildContext {
  back() {
    Navigator.pop(this);
  }

  dissmissLoading() {
    Navigator.pop(this);
  }

  pushScreen({required Widget nextScreen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => nextScreen));
  }

  pushReplacementScreen({required Widget nextScreen}) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => nextScreen));
  }
}
extension PrintLogExtension on String {
  void printLog({String? msg}) {
    if (_logEnable) {
      print('${msg??""} \x1B[32m() => $this \x1B[0m');
    }
  }

  void infoLog({String? msg}) {
    if (_logEnable) {
      print('${msg??""} \x1B[34m() => $this \x1B[0m');
    }
  }
  void errorLog({String? msg}) {
    if (_logEnable) {
      print('${msg??""} \x1B[31m() => $this \x1B[0m');
    }
  }
}

void printLog(String? value,{String? msg}) {
  if (_logEnable) {
    print('${msg??""} \x1B[32m() => $value \x1B[0m');
  }
}

void infoLog(String? value,{String? fun}) {
  if (_logEnable) {
    print('${fun??""} \x1B[34m() => $value \x1B[0m');
  }
}
void errorLog(String? value,{String? fun}) {
  if (_logEnable) {
    print('${fun??""} \x1B[31m() => $value \x1B[0m');
  }
}