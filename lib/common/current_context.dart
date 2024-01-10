import 'package:flutter/material.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
BuildContext? getCurrentContext() {
  return scaffoldMessengerKey.currentContext;
}
