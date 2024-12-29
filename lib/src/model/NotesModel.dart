class NotesModel {
  String? title;
  String? subtitle;
  bool? isImportant;
  String? date;

  NotesModel({this.title, this.subtitle, this.isImportant, this.date});

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    isImportant = json['isImportant'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['isImportant'] = this.isImportant;
    data['date'] = this.date;
    return data;
  }
}
