import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/extension/navigation.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/feature/add_note/widgets/icon_button.dart';
import 'package:notes/feature/home/pages/home_screen.dart';
import 'package:notes/feature/shared/cubit/note_cubit.dart';
import 'package:notes/feature/shared/cubit/note_state.dart';
import 'package:notes/feature/shared/model/note_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteCreatedState) {
          context.pushToReplacement(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.arrow_back_ios_new_rounded,
                ),
                CustomIconButton(onTap: () {
                  context.read<NoteCubit>().addNote(
                    NoteModel(
                      id: DateTime.now().day,
                      title: titleController.text,
                      content: contentController.text,
                      color: AppColors.greenColor,
                    ),
                  );
                }, icon: Icons.save_outlined),
              ],
            ),
          ),
          body: Column(
            children: [
              TextFormField(
                controller: titleController,
                maxLines: 2,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 35),
                ),
              ),
              TextFormField(
                controller: contentController,
                maxLines: 10,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Type something here...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 35),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
