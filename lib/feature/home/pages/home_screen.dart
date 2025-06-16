import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/extension/navigation.dart';
import 'package:notes/feature/add_note/add_note_screen.dart';
import 'package:notes/feature/shared/cubit/note_cubit.dart';
import 'package:notes/feature/shared/cubit/note_state.dart';
import 'package:notes/feature/update/update_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), centerTitle: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushTo(context, const AddNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          var notes = context.read<NoteCubit>().notes;
          if (state is NoteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoadedState) {
            return (notes.isEmpty)
                ? const Center(child: Text('No notes available', style: TextStyle(fontSize: 20, color: Colors.grey)))
                : ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to update page with the selected note
                          context.pushTo(
                            context,
                            UpdatePage(
                              noteId: notes[index].id,
                              titleController: TextEditingController(text: notes[index].title),
                              contentController: TextEditingController(text: notes[index].content),
                            ),
                          );
                        },
                        child: Container(
                          color: notes[index].color,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                          child: ListTile(
                            title: Text(notes[index].title, style: TextStyle(color: Colors.white, fontSize: 30)),
                            subtitle: Text(
                              notes[index].content,
                              style: TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(color: Colors.grey),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
