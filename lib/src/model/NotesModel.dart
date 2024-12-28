class NotesModel {
  String? title;
  String? subtitle;
  bool? isImportant;

  NotesModel({this.title, this.subtitle, this.isImportant});

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    isImportant = json['isImportant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['isImportant'] = this.isImportant;
    return data;
  }
}
