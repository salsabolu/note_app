import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note.dart';

final _lightColors = [
  Colors.orange.shade100,
  Colors.lightBlue.shade100,
  Colors.pink.shade100,
  Colors.deepPurple.shade100,
  Colors.brown.shade100,
];

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final int index;
  const NoteCardWidget({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().add_jms().format(note.createdTime);
    final minHeight = getMinHeight(index);
    final color = _lightColors[index % _lightColors.length];

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: GoogleFonts.nunitoSans(
              color: Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            )),
            const SizedBox(height: 6),
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunitoSans(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunitoSans(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 3) {
      case 0:
        return 120;
      case 1:
        return 140;
      case 2:
        return 140;
      default:
        return 120;
    }
  }
}
