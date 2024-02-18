class CategoryModel {
  String? title;
  String? picture;

  CategoryModel(this.title, this.picture);

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    title = json!['title'];
    picture = json['picture'];
  }
}
