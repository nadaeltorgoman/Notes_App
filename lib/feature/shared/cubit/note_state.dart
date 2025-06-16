class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {}

class NoteCreatedState extends NoteState {}
class NoteUpdatedState extends NoteState {}

class NoteErrorState extends NoteState {
  final String message;

  NoteErrorState(this.message);
}
