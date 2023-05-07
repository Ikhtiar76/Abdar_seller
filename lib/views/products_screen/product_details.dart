import 'package:abdar_seller/Controllers/products_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: '${data['p_name']}',size: 20.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              viewportFraction: 1.0,
              aspectRatio: 16 / 9,
              height: 350,
              itemCount: data['p_imgs'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ).box.make();
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: '${data['p_name']}',size: 20.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: '${data['p_category']}',size: 20.0),
                      10.widthBox,
                      normalText(text: '${data['p_subcategory']}',size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    size: 25,
                    normalColor: Colors.grey,
                    count: 5,
                    selectionColor: golden,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(text: '\$${data['p_price']}',size: 20.0,color: greenColor),
                  10.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          'Color:'.text.color(Colors.white).bold.make(),
                          20.widthBox,
                          Row(
                            children: List.generate(
                                data['p_colors'].length,
                                    (index) => VxBox()
                                        .margin(const EdgeInsets.symmetric(
                                        horizontal: 5))
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]))
                                        .make().onTap(() {})),
                          )
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          'Quantity:'.text.color(Colors.white).bold.make(),
                          20.widthBox,
                          boldText(text: '${data['p_quantity']} items',color: golden)
                        ],
                      )
                          .box
                          .margin(const EdgeInsets.only(right: 10))
                          .make(),
                    ],
                  ).box.padding(const EdgeInsets.all(6)).make(),
                  const Divider(color: greenColor,),
                  10.heightBox,
                  boldText(text: 'Description:',size: 18.0),
                  10.heightBox,
                  boldText(text: '${data['p_description']}',color: golden)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

