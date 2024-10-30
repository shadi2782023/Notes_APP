class NotesModel {
  String? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  String? notesUsers;

  NotesModel(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUsers});

  NotesModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'].toString();
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'].toString();
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // ignore: unnecessary_this
    data['notes_id'] = this.notesId;
    // ignore: unnecessary_this
    data['notes_title'] = this.notesTitle;
    // ignore: unnecessary_this
    data['notes_content'] = this.notesContent;
    // ignore: unnecessary_this
    data['notes_image'] = this.notesImage;
    // ignore: unnecessary_this
    data['notes_users'] = this.notesUsers;
    return data;
  }
}
