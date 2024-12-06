class TodoModel {
  String? title;
  bool? isImportant;
  bool? isCompleted;
  String? deadline;
  String? sId;
  String? createdOn;

  TodoModel(
      {required this.title,
      required this.isImportant,
      required this.isCompleted,
      required this.deadline,
      this.sId,
      required this.createdOn});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isImportant = json['isImportant'];
    isCompleted = json['isCompleted'];
    deadline = json['deadline'];
    sId = json['_id'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['isImportant'] = this.isImportant;
    data['isCompleted'] = this.isCompleted;
    data['deadline'] = this.deadline;
    data['_id'] = this.sId;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
