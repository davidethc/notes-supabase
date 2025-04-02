import 'package:flutter/material.dart';
import 'package:notes/note.dart';
import 'package:notes/note_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // database notes
  final notesDatabase = NoteDatabase();
  // text controller
  final noteController = TextEditingController();
  //user wants to add new note
  void addNewNote() {
    // show dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Note'),
          content: TextField(controller: noteController),
          actions: [
            TextButton(
              onPressed: () {
                // cancel buttom
                Navigator.pop(context);
                // clear controller
                noteController.clear();
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                // add note
                final newNote = Note(content: noteController.text);
                // save in database
                notesDatabase.ceateNote(newNote);
                // pop dialog
                // cancel buttom
                Navigator.pop(context);
                // clear controller
                noteController.clear();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  //delete
  void deleteNote() {
    // show dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Note'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                // cancel buttom
                Navigator.pop(context);
                // clear controller
                noteController.clear();
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                // add note
                final newNote = Note(content: noteController.text);
                // save in database
                notesDatabase.deleteNote(newNote);
                // pop dialog
                // cancel buttom
                Navigator.pop(context);
                // clear controller
                noteController.clear();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  //edit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notas Simple api',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: addNewNote,
          label: Text('Add Note', style: TextStyle(fontSize: 16)),
          icon: Icon(Icons.add_rounded),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: StreamBuilder(
        stream: notesDatabase.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            );
          }
          final notes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(51, 255, 255, 255),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(20),
                    title: Text(
                      note.content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_rounded),
                          color: Color.fromARGB(255, 137, 137, 159),
                          onPressed: () {
                            noteController.text = note.content;
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: Text(
                                      'Edit Note',
                                      style: TextStyle(
                                        color: Color(0xFF1A1A2F),
                                      ),
                                    ),
                                    content: TextField(
                                      controller: noteController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFF8F9FE),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Enter your note',
                                      ),
                                      maxLines: 3,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          noteController.clear();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Color(0xFF1A1A2F),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Color(0xFF1A1A2F),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            notesDatabase.updateNote(
                                              note,
                                              noteController.text,
                                            );
                                            Navigator.pop(context);
                                            noteController.clear();
                                          },
                                          child: Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_rounded),
                          color: Color(0xFFFF3B30),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    title: Text('Delete Note'),
                                    content: Text(
                                      'Are you sure you want to delete this note?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancel'),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Color(0xFFFF3B30),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            notesDatabase.deleteNote(note);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
