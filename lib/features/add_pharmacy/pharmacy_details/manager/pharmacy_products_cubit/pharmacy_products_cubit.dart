import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/product_model.dart';

part 'pharmacy_products_state.dart';

class PharmacyProductsCubit extends Cubit<PharmacyProductsState> {
  PharmacyProductsCubit() : super(PharmacyProductsInitial());

  static PharmacyProductsCubit get(context) => BlocProvider.of(context);
  List<ProductsModel> similarProducts = [];
  List<ProductsModel> categoryFilterProducts = [];
  List<ProductsModel> searchProductsList = [];
  String dropDownMenuItemValue = 'Medicine';
  TextEditingController searchController = TextEditingController();

  void getSimilarProducts(ProductsModel productsModel) {
    emit(GetSimilarProductsLoading());
    FirebaseFirestore.instance.collection('allProducts').get().then((value) {
      for (var element in value.docs) {
        element.data()['reference'].get().then((value) {
          if (value.data()['effectiveMaterial'] == productsModel.effectiveMaterial &&
              value.data()['id'] != productsModel.tag) {
            similarProducts.add(ProductsModel.fromJson(value.data()));
            emit(GetSimilarProductsSuccessfully());
          }
        }).catchError((onError) {
          emit(GetSimilarProductsError());
        });
      }
    }).catchError((onError) {
      emit(GetSimilarProductsError());
    });
  }

  void changeDropDownItem({
    required String pharmacyId,
    required category,
  }) {
    categoryFilterProducts = [];
    dropDownMenuItemValue = category;
    emit(ChangeDropDownMenuItemValue());
    if (category != 'All') {
      print(pharmacyId);
      emit(CategoryFilterInAllProductsLoading());
      FirebaseFirestore.instance
          .collection('pharmacies')
          .doc(pharmacyId.trim())
          .collection('products')
          .where('category', isEqualTo: category)
          .get()
          .then((value) {
        for (var element in value.docs) {
          categoryFilterProducts.add(ProductsModel.fromJson(element.data()));
        }
        print(value.docs);
        print(category);
        emit(CategoryFilterInAllProductsSuccessfully());
      }).catchError((onError) {
        emit(CategoryFilterInAllProductsError());
      });
    } else {
      emit(ShowAllProducts());
    }
  }

  void searchProducts(String value, List<ProductsModel> products) {
    searchProductsList = [];
    for (ProductsModel product in products) {
      if (product.name!.toLowerCase().contains(value.toLowerCase())) {
        searchProductsList.add(product);
      }
    }
    emit(IsSearchingInMedicineInCategory());
  }

  void isSearching(bool isSearching) {
    if (isSearching) {
      emit(IsSearchingInMedicineInCategory());
    } else {
      searchProductsList = [];
      emit(IsNotSearchingInMedicineInCategory());
    }
  }
}
