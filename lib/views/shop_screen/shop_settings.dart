import 'package:abdar_seller/Controllers/profile_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/custom_textfield.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 20.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async{
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopAddress: controller.shopAddressController.text,
                        shopName: controller.shopNameController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopWebsite: controller.shopWebsiteController.text,
                        shopDesc: controller.shopDescController.text,
                      );
                      VxToast.show(context, msg: 'Shop Updated');
                    },
                    child:
                        normalText(text: save, size: 20.0, color: greenColor),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: showAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: showMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: showWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  label: description,
                  hint: showDescHint,
                  controller: controller.shopDescController,
                  isDesc: true),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
