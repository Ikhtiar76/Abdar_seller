import 'package:abdar_seller/Controllers/products_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/services/store_services.dart';
import 'package:abdar_seller/views/products_screen/add_product.dart';
import 'package:abdar_seller/views/products_screen/product_details.dart';
import 'package:abdar_seller/views/widgets/appbar_widget.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await controller.getCategories();
          await controller.populateCategoryList();
          Get.to(()=> const AddProduct());
        },
        backgroundColor: greenColor,
        child: const Icon(Icons.add),
      ),
      appBar: appBarWidget(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
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
                        (index) => ListTile(
                      onTap: () {
                        Get.to(()=>  ProductDetails(data: data[index]));
                      },
                      leading: Image.network(
                        data[index]['p_imgs'][0],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: boldText(text: '${data[index]["p_name"]}', color: darkGrey),
                      subtitle: Row(
                        children: [
                          normalText(text: '\$${data[index]['p_price']}', color: golden),
                          10.widthBox,
                          normalText(text: data[index]['p_featured'] == true ?'Featured':'', color: greenColor),
                        ],
                      ),
                      trailing: VxPopupMenu(
                          menuBuilder: () => Column(
                            children: List.generate(
                                popupMenuTitles.length,
                                    (i) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        popupMenuIcons[i],
                                        color: data[index]['featured_id'] == currentUser!.uid && i==0 ? green : darkGrey,
                                      ),
                                      10.widthBox,
                                      normalText(
                                          text: data[index]['featured_id'] == currentUser!.uid && i==0 ? 'Remove feature' : popupMenuTitles[i],
                                          color: white)
                                    ],
                                  ).onTap(() {
                                    switch (i){
                                      case 0:
                                        if(data[index]['p_featured'] == true){
                                          controller.removeFeatured(data[index].id);
                                          VxToast.show(context, msg: 'Removed');
                                        }else{
                                          controller.addFeatured(data[index].id);
                                          VxToast.show(context, msg: 'Added');
                                        }
                                        break;
                                      case 1:
                                        break;
                                      case 2:
                                        controller.removeProduct(data[index].id);
                                        VxToast.show(context, msg: 'Product removed');
                                    }
                                  }),
                                )),
                          ).box.color(tileColor).roundedSM.width(200).make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(
                            Icons.more_vert_rounded,
                            color: fontGrey,
                            size: 30,
                          )),
                    )),
              ),
            ),
          );
        }
      },),
    );
  }
}
