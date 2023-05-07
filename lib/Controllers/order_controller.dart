import 'package:abdar_seller/const/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var confirm = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  var orders = [];

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      orders.add(item);
    }
  }

  changeStatus({title, status, docID}) async {
    var store = fireStore.collection(ordersCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
