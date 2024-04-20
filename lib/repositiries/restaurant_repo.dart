import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/models/restaurant_model.dart';

abstract class RestaurantRepository {
  Future<List<RestaurantModel>> getRestaurantApi(Map<String, dynamic> map);

  Future<RestaurantModel> getRestaurantDetailApi(Map<String, dynamic> map);
}

class RestaurantRepositoryImp extends RestaurantRepository {
  @override
  Future<List<RestaurantModel>> getRestaurantApi(
      Map<String, dynamic> map) async {
    List<RestaurantModel> list = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(tblRestaurant).get();
    querySnapshot.docs.forEach((element) {
      list.add(RestaurantModel(
          id: element.id,
          poster: element["poster"] ?? "",
          name: element["name"] ?? "",
          onwerName: element["onwer_name"] ?? "",
          mobile: element["mobile"] ?? "",
          email: element["email"] ?? "",
          radius: element["radius"] ?? "",
          address: element["address"] ?? "",
          category: [],
          offers: []));
    });
    return list;
  }

  @override
  Future<RestaurantModel> getRestaurantDetailApi(
      Map<String, dynamic> map) async {
    RestaurantModel restaurant = RestaurantModel(
        id: "",
        poster: "",
        name: "",
        onwerName: "",
        mobile: "",
        email: "",
        radius: "",
        address: "",
        category: [],
        offers: []);
    var categories = await FirebaseFirestore.instance
        .collection(tblCategory)
        .where("restaurant_id", isEqualTo: map["id"])
        .get();
    var productsSnapshot = await FirebaseFirestore.instance
        .collection(tblMenu)
        .where("restaurant_id", isEqualTo: map["id"])
        .get();

    var restaurantdSnapshot = await FirebaseFirestore.instance
        .collection(tblRestaurant)
        .doc(map["id"])
        .get();

    Map<String, dynamic> data =
        restaurantdSnapshot.data() as Map<String, dynamic>;
    data["id"] = map["id"];
    restaurant = RestaurantModel.fromJson(data);

    categories.docs.forEach((categoryDoc) async {
      List<Product> productList = [];
      productsSnapshot.docs
          .where((element) => element["category_id"] == categoryDoc.id)
          .forEach((productDoc) {
        print("getRestaurantDetailApi>>>>>>>>>>>category>>>>>>>");
        productList.add(Product(
          id: productDoc.id,
          type: productDoc["type"] ?? "",
          itemName: productDoc["item_name"] ?? "",
          rating: (productDoc["rating"] ?? 0.0) as double,
          ratingCount: productDoc["rating_count"] ?? 0,
          price: productDoc["price"] ?? "",
          tag: productDoc["tag"] ?? "",
          image: productDoc["image"] ?? "",
        ));
      });
      Category category = Category(
        id: categoryDoc.id,
        name: categoryDoc['name'],
        products: productList,
      );
      restaurant.category.add(category);
    });
    return restaurant;
  }
}
