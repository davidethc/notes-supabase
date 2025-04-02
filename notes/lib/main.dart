import 'package:flutter/material.dart';
import 'package:notes/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //supabase setup
  await Supabase.initialize(
    url: "https://adshfmkbkqwgezrdbsea.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFkc2hmbWtia3F3Z2V6cmRic2VhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM1MjQxMDAsImV4cCI6MjA1OTEwMDEwMH0.FU_vG2MyM1Q1A-JS3O76R3NRG5HkNEsbNdJRlHiP1Kg",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NotePage());
  }
}
