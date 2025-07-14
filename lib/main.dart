import 'package:chat/Pages/chatapp.dart';
import 'package:chat/cubit/cubits/login_cubit.dart';
import 'package:chat/cubit/cubits/register_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/Login_Page.dart';
import 'Pages/Register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) =>RegisterCubit(),),
      ],
      child: MaterialApp(
        routes: {
          loginApp.id: (context) => loginApp(),
         Register.id: (context) => Register(),
          chat.id: (context) => chat(),
        },
        debugShowCheckedModeBanner: false,
        home: loginApp(),
      ),
    );
  }
}
