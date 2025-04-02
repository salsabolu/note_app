import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/database/note_database.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/pages/add_edit_note_page.dart';
import 'package:note_app/pages/note_detail_page.dart';
import 'package:note_app/widgets/note_card_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;
  var isLoading = false;

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });

    notes = await NoteDatabase.instance.getAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Notes'),
        titleTextStyle: GoogleFonts.nunitoSans(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFFA3A194),
      ),
      body: Container(
        color: const Color(0xFFEEEEEE),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : notes.isEmpty
                ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/No_Results.svg',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Note is empty',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                )
                : MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  padding: const EdgeInsets.all(10),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetailPage(id: note.id!),
                          ),
                        );
                        refreshNotes();
                      },
                      child: NoteCardWidget(note: note, index: index),
                    );
                  },
                ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEEEEEE),
        foregroundColor: const Color(0xFF888888),
        tooltip: 'Add Note',
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditNotePage()),
          );
          refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
