import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';

abstract class PropertyRepository {
  Future<List<PropertyModel>> getPropertyApi(Map<String, dynamic> map);
}

class PropertyRepositoryImp extends PropertyRepository {
  @override
  Future<List<PropertyModel>> getPropertyApi(Map<String, dynamic> map) async {
    List<PropertyModel> list = [];

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query query = firestore.collection(tblProperty);
    if (map["type"] != "") {
      query = query.where("type", isEqualTo: map["type"]);
    }
    QuerySnapshot querySnapshot = await query.get();

    for (var element in querySnapshot.docs!) {
      List<ImagesList> imagesList = [] ;
      var images = await element.reference.collection(tblImages).get();
      print("images.docs.length>>>>>${images.docs.length}") ;
      for (var img in images.docs!) {
        imagesList.add(ImagesList(url: img["url"]));
      }

      list.add(PropertyModel(
        title: element["title"],
        description: element["description"],
        area: element["area"],
        price: element["price"],
        address: element["address"],
        latitude: 0.0,
        longitude: 0.0,
        furnishing: element["furnishing"],
        bedrooms: element["bedrooms"],
        bathrooms: element["bathrooms"],
        leaseType: element["lease_type"],
        parking: element["parking"],
        gasPipeline: element["gas_pipeline"],
        imagesList: imagesList ,
      ));
    }

    return list;
  }
}
