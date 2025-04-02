import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/widgets/note_form_widgets.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({super.key, this.note});

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  final _formKey = GlobalKey<FormState>();
  var isUpdateForm = false;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 1;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    isUpdateForm = widget.note != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        titleTextStyle: GoogleFonts.nunitoSans(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFFA3A194),
        actions: [buildButtonSave()],
      ),
      body: Container(
        color: const Color(0xFFEEEEEE),
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangeIsImportant: (value) {
              setState(() {
                isImportant = value;
              });
            },
            onChangeNumber: (value) {
              setState(() {
                number = value;
              });
            },
            onChangeTitle: (value) {
              title = value;
            },
            onChangeDescription: (value) {
              description = value;
            },
          ),
        ),
      ),
    );
  }

  buildButtonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(const Color(0xFFEEEEEE)),
          padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
          ),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            if (isUpdateForm) {
              // Update data
              await updateNote();
            } else {
              // Tambah data
              await addNote();
            }
            // Tutup halaman
            Navigator.pop(context);
          }
        },
        child: Text(
          'Save',
          style: GoogleFonts.nunitoSans(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future addNote() async {
    final note = Note(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);
  }

  Future updateNote() async {
    final updateNote = widget.note?.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );
    await NoteDatabase.instance.updateNote(updateNote!);
  }
}
