import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/services/store_services.dart';
import 'package:abdar_seller/views/products_screen/product_details.dart';
import 'package:abdar_seller/views/widgets/appbar_widget.dart';
import 'package:abdar_seller/views/widgets/dashboard_button.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(dashBoard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashBoardButton(context,
                          title: products, count: "${data.length}", icon: icProducts),
                      dashBoardButton(context,
                          title: orders, count: "${data.length}", icon: icOrders)
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashBoardButton(context,
                          title: rating, count: "${data.length}", icon: icStar),
                      dashBoardButton(context,
                          title: totalSales, count: "${data.length}", icon: icOrders)
                    ],
                  ),
                  10.heightBox,
                  const Divider(
                    color: greenColor,
                  ),
                  10.heightBox,
                  boldText(
                    text: popular,
                    size: 16.0,
                  ),
                  20.heightBox,
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_imgs'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: '${data[index]['p_name']}',
                                      color: darkGrey),
                                  subtitle: normalText(
                                      text: '\$${data[index]['p_price']}',
                                      color: golden),
                                )),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
