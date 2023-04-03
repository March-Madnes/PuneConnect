import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'src/app.dart'; 

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setHashUrlStrategy();

  runApp(const PuneConnect());
}
