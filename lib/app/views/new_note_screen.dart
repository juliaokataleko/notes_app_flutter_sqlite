import 'package:flutter/material.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {

  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova nota"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    labelText: 'Título', border: OutlineInputBorder()),
              ),
              Container(height: 30,),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Descrição', border: OutlineInputBorder()),
              )
                      ],
                    ),
            )),
      ),
    );
  }
}
