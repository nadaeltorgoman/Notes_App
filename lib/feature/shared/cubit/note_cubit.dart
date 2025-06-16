import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/services/local_storage.dart';
import 'package:notes/feature/shared/cubit/note_state.dart';
import 'package:notes/feature/shared/model/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitialState());

  List<NoteModel> notes = [];
  void getNotes() {
    emit(NoteLoadingState());
    notes = AppLocalStorage.getAllNotes();
    emit(NoteLoadedState());
  }

  void addNote(NoteModel note) {
    emit(NoteLoadingState());
    AppLocalStorage.addNote(note);
    emit(NoteCreatedState());
  }

  void deleteNote(int index) {
    emit(NoteLoadingState());
    AppLocalStorage.deleteNote(index);
    emit(NoteLoadedState());
  }

  void updateNote(int index, NoteModel note) {
    emit(NoteLoadingState());
    AppLocalStorage.updateNote(index, note);
    emit(NoteUpdatedState());
  }
}
