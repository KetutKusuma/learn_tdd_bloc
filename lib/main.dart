import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_tdd_bloc/core/services/injection_container.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/cubit/authentication_cubit.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/views/screens/home_screen.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
