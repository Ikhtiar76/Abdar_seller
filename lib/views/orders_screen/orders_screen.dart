import 'package:abdar_seller/Controllers/order_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/services/store_services.dart';
import 'package:abdar_seller/views/orders_screen/order_details.dart';
import 'package:abdar_seller/views/widgets/appbar_widget.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appBarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return loadingIndicator();
        }else{

          var data = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                    data.length,
                        (index){
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      onTap: () {
                        Get.to(()=> OrderDetails(data: data[index],));
                      },
                      tileColor: tileColor,
                      title: boldText(text: '${data[index]['order_code']}', color: Vx.black),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month,color: Vx.black,),
                              10.widthBox,
                              normalText(text: intl.DateFormat.yMd().format(time), color: lightGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.payment,color: Vx.black,),
                              10.widthBox,
                              normalText(text: unpaid, color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(text: '\$ ${data[index]['total_amount']}',size: 16.0,color: golden),
                    ).box.margin(const EdgeInsets.only(bottom: 5)).make();}
                ),
              ),
            ),
          );
        }
      },)
    );
  }
}
