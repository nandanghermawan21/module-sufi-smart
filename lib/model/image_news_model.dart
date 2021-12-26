class ImgNewsModel {
  int? newsid;
  String? imagepath;

  ImgNewsModel({this.imagepath, this.newsid});

  factory ImgNewsModel.fromJson(Map<String, dynamic> json) {
    return ImgNewsModel(
      newsid: json['newsid'] as int,
      imagepath: json['imagepath'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'newsid': newsid,
        'imagepath': imagepath,
      };

  static List<ImgNewsModel> dummy() {
    return [
      ImgNewsModel(
        imagepath:
            "https://www.sfi.co.id/assets/images/news/Brosur-PRIME-CUSTOMER-Action-Figure.jpg",
        newsid: 1,
      ),
      ImgNewsModel(
        imagepath:
            "https://www.sfi.co.id/assets/images/news/Brosur-PRIME-CUSTOMER-Action-Figure.jpg",
        newsid: 2,
      ),
      ImgNewsModel(
        imagepath:
            "https://www.sfi.co.id/assets/images/news/Brosur-PRIME-CUSTOMER-Action-Figure.jpg",
        newsid: 3,
      ),
    ];
  }
}
