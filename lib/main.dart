import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes/core/services/local_storage.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/feature/shared/cubit/note_cubit.dart';
import 'package:notes/feature/shared/model/note_model.dart';

import 'feature/home/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  await Hive.openBox<NoteModel>(AppLocalStorage.noteBoxName);
  AppLocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: MaterialApp(
        title: 'Notes App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.background,
            titleTextStyle: TextStyle(
              color: AppColors.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            elevation: 2.0,
            iconSize: 35.0,
          ),
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
