import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notes/core/extension/navigation.dart';
import 'package:notes/core/utils/app_colors.dart';
import 'package:notes/feature/add_note/widgets/icon_button.dart';
import 'package:notes/feature/home/pages/home_screen.dart';
import 'package:notes/feature/shared/cubit/note_cubit.dart';
import 'package:notes/feature/shared/cubit/note_state.dart';
import 'package:notes/feature/shared/model/note_model.dart';

class UpdatePage extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final int noteId;
  const UpdatePage({
    super.key,
    required this.noteId,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteUpdatedState) {
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
                Column(
                  children: [
                    CustomIconButton(
                      onTap: () => Navigator.pop(context),
                      icon: Icons.arrow_back_ios_new_rounded,
                    ),
                    Text(
                      'Update Note',
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomIconButton(onTap: (){
                      context.read<NoteCubit>().deleteNote(noteId);
                      context.pushToReplacement(context, const HomeScreen());
                    }, icon: Icons.delete_outline),
                    CustomIconButton(onTap: () {
                      context.read<NoteCubit>().updateNote(
                        noteId,
                        NoteModel(
                          id: noteId,
                          title: titleController.text,
                          content: contentController.text,
                          color: AppColors.greenColor,
                        ),
                      );
                    }, icon: Icons.save_outlined),
                  ],
                ),
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
