import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
