import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salons/logic/bloc/salons_bloc/salons_bloc.dart';
import 'package:salons/logic/repositories/salons_repository.dart';
import 'logic/bloc/search_bloc/search_bloc.dart';
import 'logic/repositories/search_repository.dart';
import 'screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                SearchBloc(searchRepository: SearchRepository())),
        BlocProvider(
            create: (context) =>
                SalonsBloc(salonsRepository: SalonsRepository())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salons',
        home: HomePage(),
      ),
    );
  }
}
