class NotesModel {
  final int? id;
  final String title;
  final String description;

  NotesModel({this.id, required this.title, required this.description});

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        description = res["description"];

  Map<String, Object> toMap() {
    return {"id": id ?? 0, "title": title, "description": description};
  }

  Map<String, Object> toMapWithoutId() {
    return {"title": title, "description": description};
  }
}
