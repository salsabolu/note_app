import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({
    Key? key,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.onChangeIsImportant,
    required this.onChangeNumber,
    required this.onChangeTitle,
    required this.onChangeDescription,
  }) : super(key: key);

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: isImportant,
                  onChanged: onChangeIsImportant,
                  activeColor: const Color.fromARGB(255, 199, 224, 202),
                  activeTrackColor: const Color.fromARGB(255, 160, 186, 162),
                  inactiveThumbColor: const Color(0xFFEEEEEE),
                  inactiveTrackColor: const Color(0xFFA3A194),
                  trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                Expanded(
                  child: Slider(
                    value: number.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) => onChangeNumber(value.toInt()),
                    thumbColor: const Color.fromARGB(255, 160, 186, 162),
                    activeColor: const Color.fromARGB(255, 160, 186, 162),
                  ),
                ),
              ],
            ),
            buildTitleField(),
            buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: GoogleFonts.nunitoSans(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (title) {
        return title != null && title.isEmpty
            ? 'The title cannot be empty!'
            : null;
      },
      onChanged: onChangeTitle,
    );
  }

  buildDescriptionField() {
    return TextFormField(
      maxLines: number == 0 ? null : number,
      initialValue: description,
      style: GoogleFonts.nunitoSans(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something...',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (desc) {
        return desc != null && desc.isEmpty
            ? 'The description cannot be empty!'
            : null;
      },
      onChanged: onChangeDescription,
    );
  }
}
