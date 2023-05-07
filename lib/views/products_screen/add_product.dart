import 'package:abdar_seller/Controllers/products_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/products_screen/components/product_dropdown.dart';
import 'package:abdar_seller/views/products_screen/components/product_images.dart';
import 'package:abdar_seller/views/widgets/custom_textfield.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(()=> Scaffold(
          appBar: AppBar(
            title: boldText(text: 'Add Product', size: 20.0),
            actions: [
              controller.isLoading.value
                  ? loadingIndicator()
                  : TextButton(
                      onPressed: () async{
                        controller.isLoading(true);
                        await controller.uploadImages();
                        await controller.uploadProduct(context);
                        Get.back();
                      },
                      child: boldText(text: save, color: greenColor, size: 20.0))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                      label: 'Product name',
                      hint: 'eg. BMW',
                      controller: controller.pNameController),
                  10.heightBox,
                  customTextField(
                      label: 'Description',
                      hint: '.............',
                      isDesc: true,
                      controller: controller.pDescController),
                  10.heightBox,
                  customTextField(
                      label: 'Price',
                      hint: 'eg. \$100',
                      controller: controller.pPriceController),
                  10.heightBox,
                  customTextField(
                      label: 'Quantity',
                      hint: '20',
                      controller: controller.pQuantityController),
                  10.heightBox,
                  productDropdown('Category', controller.categoryList,
                      controller.categoryValue, controller),
                  10.heightBox,
                  productDropdown('Subcategory', controller.subcategoryList,
                      controller.subcategoryValue, controller),
                  10.heightBox,
                  const Divider(
                    color: greenColor,
                  ),
                  10.heightBox,
                  normalText(text: 'Choose product images', color: golden),
                  5.heightBox,
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => controller.pImagesList[index] != null
                              ? Image.file(
                                  controller.pImagesList[index],
                                  width: 80,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : productImages(label: '${index + 1}').onTap(() {
                                  controller.pickImage(index, context);
                                })),
                    ),
                  ),
                  5.heightBox,
                  normalText(
                      text: 'First image will be your display image',
                      color: golden),
                  10.heightBox,
                  const Divider(
                    color: greenColor,
                  ),
                  10.heightBox,
                  normalText(
                    text: 'Choose product colors',
                  ),
                  10.heightBox,
                  Obx(
                    () => Wrap(
                      runSpacing: 8.0,
                      spacing: 8.0,
                      children: List.generate(
                          9,
                          (index) => Stack(
                                alignment: Alignment.center,
                                children: [
                                  VxBox()
                                      .color(Vx.randomPrimaryColor)
                                      .size(65, 65)
                                      .roundedFull
                                      .make()
                                      .onTap(() {
                                    controller.selectedColorIndex.value = index;
                                  }),
                                  controller.selectedColorIndex.value == index
                                      ? const Icon(
                                          Icons.done,
                                          color: white,
                                        )
                                      : const SizedBox()
                                ],
                              )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
