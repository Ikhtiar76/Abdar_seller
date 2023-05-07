import 'package:abdar_seller/const/const.dart';
class StoreServices {
  static getProfile(uid){
    return fireStore.collection(vendorsCollection).where('id', isEqualTo: uid).get();
  }

  static getMessages(uid){
    return fireStore.collection(chatsCollection).where('toId', isEqualTo: uid).snapshots();
  }
  
  
  static getOrders(uid){
    return fireStore.collection(ordersCollection).where('vendors',arrayContains: uid).snapshots();
  }
  
  
  
  static getProducts(uid){
    return fireStore.collection(productsCollection).where('vendor_id',isEqualTo: uid).snapshots();
  }


}