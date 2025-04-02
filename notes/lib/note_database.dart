import 'package:notes/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {
  // database -> notes
  final database = Supabase.instance.client.from('notes');
  //create
  Future ceateNote(Note newNote) async {
    await database.insert(newNote.toMap());
  }

  //read
  final Stream<List<Note>> stream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id'])
      .map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());

  //update
  Future updateNote(Note oldNote, String newContent) async {
    await database.update({'content': newContent}).eq('id', oldNote.id!);
  }

  //delete
  Future deleteNote(Note note) async {
    await database.delete().eq('id', note.id!);
  }
}
