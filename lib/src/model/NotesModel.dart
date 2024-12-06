class NotesModel {
  String? title;
  String? subtitle;
  bool? isImportant;
  String? sId;

  NotesModel({this.title, this.subtitle, this.isImportant, this.sId});

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    isImportant = json['isImportant'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['isImportant'] = this.isImportant;
    data['_id'] = this.sId;
    return data;
  }
}
