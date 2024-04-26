import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';

abstract class PropertyRepository {
  Future<List<PropertyModel>> addPropertyApi(Map<String, dynamic> map);

  Future<List<PropertyModel>> getPropertyApi(Map<String, dynamic> map);

  Future<PropertyModel> getPropertyDetailApi(Map<String, dynamic> map);
}

class PropertyRepositoryImp extends PropertyRepository {
  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      return null;
    }
    UploadTask uploadTask;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('property')
        .child('/${DateTime.now()}_${file.name}');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    return Future.value(uploadTask);
  }

  @override
  Future<List<PropertyModel>> addPropertyApi(Map<String, dynamic> map) async {

    List<PropertyModel> list = [];
    var imagesUrl = [];
    for (XFile file in map["files"]) {
      UploadTask? uploadTask = await uploadFile(file);
      if (uploadTask == null) {
      } else {
        final String downloadURL =
            await (await uploadTask).ref.getDownloadURL();
        imagesUrl.add(downloadURL);
        print('Image uploaded to Firebase: $downloadURL');
      }
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference propertyRef =
        await firestore.collection('Properties').add({
          "seller_id": "SEL345534",
          "title": map["title"],
          "description": map["description"],
          "area": int.parse(map["area"]),
          "price": int.parse(map["price"]),
          "address": map["address"],
          "latitute": 37.54545,
          "longitude": 73.54544,
          "furnishing": map["furnishing"],
          "bedrooms": int.parse(map["bedrooms"]),
          "bathrooms": int.parse(map["bathrooms"]),
          "lease_type": map["lease_type"],
          "parking": map["parking"],
          "type": map["type"],
          "gas_pipeline": true,
         });

    final CollectionReference imagesRef = propertyRef.collection('Images');
    for (String url in imagesUrl) {
      imagesRef.add({
        "url": url,
      });
    }


    Query query = firestore.collection(tblProperty);
    if (map["type"] != "") {
      query = query.where("type", isEqualTo: map["type"]);
    }
    QuerySnapshot querySnapshot = await query.get();

    for (var element in querySnapshot.docs!) {
      List<ImagesList> imagesList = [];
      var images = await element.reference.collection(tblImages).get();
      print("images.docs.length>>>>>${images.docs.length}");
      var isPrimary = true;
      for (var img in images.docs!) {
        imagesList.add(ImagesList(url: img["url"], isPrimary: isPrimary));
        isPrimary = false;
      }

      list.add(PropertyModel(
        id: element.id,
        seller_id: element["seller_id"],
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
        imagesList: imagesList,
      ));
    }

    return list;
  }

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
      List<ImagesList> imagesList = [];
      var images = await element.reference.collection(tblImages).get();
      print("images.docs.length>>>>>${images.docs.length}");
      var isPrimary = true;
      for (var img in images.docs!) {
        imagesList.add(ImagesList(url: img["url"], isPrimary: isPrimary));
        isPrimary = false;
      }

      list.add(PropertyModel(
        id: element.id,
        title: element["title"],
        seller_id: element["seller_id"],
        description: element["description"],
        area: element["area"] as int,
        price: element["price"] as int,
        address: element["address"],
        latitude: 0.0,
        longitude: 0.0,
        furnishing: element["furnishing"],
        bedrooms: element["bedrooms"] as int,
        bathrooms: element["bathrooms"] as int,
        leaseType: element["lease_type"],
        parking: element["parking"],
        gasPipeline: element["gas_pipeline"],
        imagesList: imagesList,
      ));
    }

    return list;
  }

  @override
  Future<PropertyModel> getPropertyDetailApi(Map<String, dynamic> map) async {
    PropertyModel restaurant = PropertyModel(
      id: "",
      title: "",
      seller_id: "",
      description: "",
      area: 0,
      price: 0,
      address: "",
      latitude: 0,
      longitude: 0,
      furnishing: "",
      bedrooms: 0,
      bathrooms: 0,
      leaseType: "",
      parking: "",
      gasPipeline: false,
      imagesList: [],
    );

    return restaurant;
  }
}
