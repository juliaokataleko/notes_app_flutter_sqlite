import 'package:flutter/material.dart';
import 'package:flutter_sqlite_app/app/helpers/db_handler.dart';
import 'package:flutter_sqlite_app/app/models/notes.dart';
import 'package:flutter_sqlite_app/app/views/new_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHandler? dbHandler;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    // implement initState
    super.initState();

    dbHandler = DBHandler();
    _loadNotes();
  }

  _loadNotes() async {
    notesList = dbHandler!.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        reverse: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var title = "";
                          var description = "";
                          int id = 0;

                          if (snapshot.data != null) {
                            id = int.parse(snapshot.data![index].id.toString());
                            title = snapshot.data![index].title.toString();
                            description =
                                snapshot.data![index].description.toString();
                          }

                          return InkWell(
                            onTap: () {

                              dbHandler!.update(
                                NotesModel(
                                  id: id,
                                  title: "O que é o Lorem Ipsum?",
                                  description: "O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão. O Lorem Ipsum tem vindo a ser o texto padrão usado por estas indústrias desde o ano de 1500,"
                                )
                              );

                              setState(() {
                                notesList = dbHandler!.getNotes();
                              });

                            },
                            child: Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete_forever),
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  dbHandler!.delete(id);
                                  notesList = dbHandler!.getNotes();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(10.8),
                                  title: Text(title),
                                  subtitle: Text(description),
                                  trailing: Text(id.toString()),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          // dbHandler!
          //     .insert(NotesModel(
          //         title: "Primeira nota",
          //         description:
          //             "lorem Ips et dolor sit amet, consectetur adipiscing elit"))
          //     .then((value) {

          //   setState(() {
          //     _loadNotes();
          //   });
            
          // }).onError((error, stackTrace) {
          //   print(error.toString());
          // });

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewNoteScreen()));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
