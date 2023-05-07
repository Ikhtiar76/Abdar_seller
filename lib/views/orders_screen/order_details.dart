import 'package:abdar_seller/Controllers/order_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/orders_screen/components/order_place.dart';
import 'package:abdar_seller/views/widgets/my_button.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key,this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirm.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {

    return Obx(()=> Scaffold(
        appBar: AppBar(
          title: boldText(text: 'Order Details', size: 20.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirm.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child:
                myButton(color: greenColor, onPress: () {
                  controller.confirm(true);
                  controller.changeStatus(title: 'order_confirmed',status: true,docID: widget.data.id);
                }, title: 'Confirm Order'),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // order delivery status section
              Visibility(
                visible: controller.confirm.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: 'Order status',size: 20.0,color: golden),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: 'Placed',color: white),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: controller.confirm.value,
                      onChanged: (value) {
                        controller.confirm.value = value;
                      },
                      title: boldText(text: 'Confirmed',color: white),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: controller.onDelivery.value,
                      onChanged: (value) {
                        controller.onDelivery.value = value;
                        controller.changeStatus(title: 'order_on_delivery',status: value,docID: widget.data.id);
                      },
                      title: boldText(text: 'on Delivery',color: white),
                    ),
                    SwitchListTile(
                      activeColor: greenColor,
                      value: controller.delivered.value,
                      onChanged: (value) {
                        controller.delivered.value = value;
                        controller.changeStatus(title: 'order_delivered',status: value,docID: widget.data.id);
                      },
                      title: boldText(text: 'Delivered',color: white),
                    ),
                  ],
                )
                    .box.padding(const EdgeInsets.all(8))
                    .roundedSM
                    .shadowSm
                    .color(tileColor)
                    .margin(const EdgeInsets.all(8))
                    .make(),
              ),

              // order details section
              Column(
                children: [
                  orderPlaceDetails(
                      title1: 'Order Code',
                      title2: 'Shipping Method',
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}"),
                  orderPlaceDetails(
                      title1: 'Order Date',
                      title2: 'Payment Method',
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((widget.data['order_date'].toDate())),
                      d2: "${widget.data['payment_method']}"),
                  orderPlaceDetails(
                      title1: 'Delivery Status',
                      title2: 'Payment Status',
                      d1: 'Unpaid',
                      d2: 'Order Placed'),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(text: 'Shipping Address', color: white),
                            /*"Shipping Address"
                                .text
                                .size(20)
                                .fontFamily(bold)
                                .color(colorA)
                                .make(),*/
                            "${widget.data['order_by_name']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_email']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_address']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_city']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_state']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_phone']}"
                                .text
                                .color(Colors.white)
                                .make(),
                            "${widget.data['order_by_postalcode']}"
                                .text
                                .color(Colors.white)
                                .make(),
                          ],
                        ),
                        Column(
                          children: [
                            boldText(text: "Total Amount", color: greenColor),
                            boldText(text: "\$${widget.data['total_amount']}", color: greenColor),
                          ],
                        ).box.margin(EdgeInsets.only(right: 45)).make()
                      ],
                    ),
                  ),
                ],
              )
                  .box
                  .roundedSM
                  .shadowSm
                  .color(tileColor)
                  .margin(const EdgeInsets.all(8))
                  .make(),
              boldText(text: "Ordered Products", color: white, size: 20.0),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(controller.orders.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: "${controller.orders[index]['title']}",
                          title2: "\$${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qty']}x",
                          d2: 'Refundable'),
                      Container(
                        margin: const EdgeInsets.only(left: 16, bottom: 10),
                        width: 30,
                        height: 10,
                        color: Color(controller.orders[index]['color']),
                      )
                    ],
                  );
                }).toList(),
              )
                  .box
                  .roundedSM
                  .shadowSm
                  .color(tileColor)
                  .margin(const EdgeInsets.all(8))
                  .make(),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
