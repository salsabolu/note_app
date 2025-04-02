import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/pages/add_edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int id;
  const NoteDetailPage({super.key, required this.id});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  var isLoading = true;

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    note = await NoteDatabase.instance.getNoteById(widget.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        titleTextStyle: GoogleFonts.nunitoSans(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFFA3A194),
        actions: [editButton(), deleteButton()],
      ),
      body: Container(
        color: const Color(0xFFEEEEEE),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      note.title,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: GoogleFonts.nunitoSans(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text(
                      note.description,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget editButton() => IconButton(
    icon: const Icon(Icons.edit_outlined),
    onPressed: () async {
      if (isLoading) return;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddEditNotePage(note: note)),
      );
      refreshNote();
    },
  );

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      if (isLoading) return;
      await NoteDatabase.instance.deleteNoteById(widget.id);
      Navigator.pop(context);
    },
  );
}
