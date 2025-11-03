import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handcrafts/providers/cart_provider.dart';
import 'package:handcrafts/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),

      ],
      child: const HandicraftsApp(),
    ),
  );
}
