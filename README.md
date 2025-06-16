# 📝 Notes App

A lightweight and simple Notes app built with **Flutter**, using **Hive** for local storage and **Cubit** for reactive state management. You can effortlessly **add**, **update**, and **delete** your notes — all offline.

![Flutter](https://img.shields.io/badge/flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Hive](https://img.shields.io/badge/hive-F0C420?style=for-the-badge&logo=hive&logoColor=white)
![Cubit](https://img.shields.io/badge/cubit-3399FF?style=for-the-badge&logo=bloc&logoColor=white)

---

## ✨ Features

- 🆕 Add new notes
- 📝 Update existing notes
- ❌ Delete notes
- 📦 Offline-first using Hive
- ⚡ Reactive & testable logic with Cubit
- 🧠 Feature-based modular structure
- 💅 Clean UI and easy UX

<!-- --- -->

<!--## 📸 Screenshots-->

<!-- Add your app screenshots here -->
<!-- Example: ![screenshot](assets/screenshot1.png) -->

---

## 📦 Dependencies

| Package       | Description                   |
|---------------|-------------------------------|
| `hive`        | Lightweight key-value database|
| `hive_flutter`| Flutter adapter for Hive      |
| `flutter_bloc`| Bloc & Cubit state management |

---

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/nadaeltorgoman/notes_app.git
cd notes_app
```

### 2. Install Dependencies

```bash
flutter pub get
```
### 3. Generate Hive Adapters
``` bash
flutter packages pub run build_runner build
```
### 4. Run the App
``` bash
flutter run
```
---
### 🗂️ Project Structure
```
lib/
├── core/
│   ├── extension/       # Dart/Flutter extensions (e.g., DateTime formatting)
│   ├── services/        # Hive initialization, navigation, etc.
│   └── utils/           # Constants, themes, helpers
│
├── features/
│   ├── add_note/
│   │   ├── widgets/     # Components specific to adding notes
│   │   └── pages/       # Add note screen(s)
│   │
│   ├── home/
│   │   ├── widgets/     # Home screen UI elements
│   │   └── pages/       # Home screen logic
│   │
│   ├── update/
│   │   ├── widgets/     # Update-specific UI elements
│   │   └── pages/       # Update note screen(s)
│   │
│   └── shared/
│       ├── cubit/       # NoteCubit and NoteState
│       └── model/       # Hive models (e.g., NoteModel)
│
└── main.dart            # Entry point and root widget
```
### 🗃️ Hive Local Storage
The app uses Hive for local, NoSQL data persistence. All notes are stored in a Hive box named:
```
const String noteBoxName = 'notes';
```
---
### 📦 NoteModel
Your NoteModel is annotated with HiveType and stores the following fields:
```
@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final Color color;

  // Optional:
  // @HiveField(4) final DateTime createdAt;
  // @HiveField(5) final DateTime updatedAt;
}
```
🔧 Note: Color is saved as an int using Color(value) constructor.

---
### 🧠 Adapter
The adapter is auto-generated using:

```
flutter packages pub run build_runner build
```
The generated adapter is located in note_model.g.dart and handles serialization/deserialization for Hive.

---
### 💾 Local Storage Operations
Your local storage logic is centralized in AppLocalStorage:
```
class AppLocalStorage {
  static late Box<NoteModel> noteBox;

  static init() {
    noteBox = Hive.box<NoteModel>('notes');
  }

  static addNote(NoteModel note) => noteBox.add(note);

  static updateNote(int index, NoteModel note) => noteBox.putAt(index, note);

  static deleteNote(int index) => noteBox.deleteAt(index);

  static List<NoteModel> getAllNotes() => noteBox.values.toList();
}
```
✅ Best Practice: call AppLocalStorage.init() after Hive is initialized and before interacting with the box.

---
🧪 Bonus Tip: Initialization Example
===
Here's how to properly initialize Hive and register the adapter in main.dart:
```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');

  AppLocalStorage.init();

  runApp(MyApp());
}
```
---
### 🧠 State Management

. This project uses Cubit, a lighter version of Bloc, for:

. Managing the list of notes

. Handling create/edit/delete actions

. Emitting UI states cleanly and efficiently

. Code lives in `features/shared/cubit/`


---

### 🙌 Contributing
Contributions are welcome! Please fork this repo and open a Pull Request with your improvements.

---

### 📄 License
This project is open-sourced under the MIT License. See the LICENSE file for details.

---
## 👤 Author
### Nada Eltorgoman
🔗 GitHub: [@nadaeltorgoman](https://github.com/nadaeltorgoman)

Built with ❤️ using Flutter.

---
