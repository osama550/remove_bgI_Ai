import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_ai/cubit/image_cubit.dart';
import 'package:image_ai/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'btg remover app',
        home: HomeScreen(),
      ),
    );
  }
}

