import 'package:hive/hive.dart';
import 'package:notes/feature/shared/model/note_model.dart';

class AppLocalStorage {
  static late Box<NoteModel> noteBox;
  static String noteBoxName = 'notes';
  static init() {
    noteBox = Hive.box<NoteModel>(noteBoxName);
  }

  static addNote(NoteModel note) {
    noteBox.add(note);
  }

  static deleteNote(int index) {
    noteBox.deleteAt(index);
  }

  static updateNote(int index, NoteModel note) {
    noteBox.putAt(index, note);
  }

  static List<NoteModel> getAllNotes() {
    return noteBox.values.toList();
  }

  static NoteModel? getNote(String key) {
    return noteBox.get(key);
  }
}
