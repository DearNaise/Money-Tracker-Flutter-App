import 'package:checklist_app/provider/activity_provider.dart';
import 'package:checklist_app/provider/wishlist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:checklist_app/view/authentication/welcome.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ActivityProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => WishlistProvider(), // Add WishlistProvider here
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Focus Point',
          home: WelcomePage(),
        )
    );
  }
}