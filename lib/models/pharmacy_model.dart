import 'category_model.dart';
import 'offers_model.dart';
import 'product_model.dart';
import 'review_model.dart';

class PharmacyModel {
  String? name;
  String? image;
  String? id;
  String? phoneNo;
  String? address;
  String? creationDate;
  List<CategoryModel>? categories;
  List<ReviewModel>? reviews;
  List<ProductsModel>? products;
  List<OffersModel>? offers;

  PharmacyModel(
    this.name,
    this.image,
    this.id,
    this.phoneNo,
    this.address,
    this.creationDate,
    this.categories,
  );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phoneNo': phoneNo,
        'address': address,
        'image': image,
        'creationDate': creationDate,
        'categories': [
          {
            'title': '',
            'picture': '',
          }
        ],
      };

  PharmacyModel.fromJson({
    Map<String, dynamic>? json,
    this.reviews,
    this.products,
    this.categories,
    this.offers,
  }) {
    name = json!['name'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    image = json['image'];
    id = json['id'];
    creationDate = json['creationDate'];
  }
}
