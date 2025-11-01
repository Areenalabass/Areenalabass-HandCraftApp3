import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handcrafts/providers/cart_provider.dart';
import 'package:handcrafts/app.dart'; // Import the new app file

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // You can add more providers here as your app grows
      ],
      child: const HandicraftsApp(),
    ),
  );
}
