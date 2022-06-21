class PopupModel {
  final String? title;
  final String? content;
  final String? image;
  final String? nokonktrak;
  final String? id;
  final String? key;

  PopupModel({
    this.title,
    this.content,
    this.image,
    this.nokonktrak,
    this.id,
    this.key,
  });

  factory PopupModel.fromJson(Map<String, dynamic> json) {
    return PopupModel(
      title: json["title"] as String?,
      content: json["content"] as String?,
      image: json["image"] as String?,
      nokonktrak: json["nokonktrak"] as String?,
      id: json["id"] as String?,
      key: json["key"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "image": image,
      "nokonktrak": nokonktrak,
      "id": id,
      "key": key,
    };
  }
}
