import 'package:abdar_seller/Controllers/auth_controller.dart';
import 'package:abdar_seller/Controllers/profile_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/services/store_services.dart';
import 'package:abdar_seller/views/auth_screen/login_screen.dart';
import 'package:abdar_seller/views/messages_screen/messages_screen.dart';
import 'package:abdar_seller/views/profile_screen/edit_profile.dart';
import 'package:abdar_seller/views/shop_screen/shop_settings.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 20.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                  username: controller.snapshotData['vendor_name'],
                ));

              },
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: () async{
            Get.find<AuthController>().signOut(context);
            Get.offAll(()=> const LoginScreen());
          }, icon: icLogout),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return loadingIndicator();
          }else {

            controller.snapshotData = snapshot.data!.docs[0];

            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imgUrl'] ==''?
                  Image.asset(imgProduct,width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                      :Image.network(controller.snapshotData['imgUrl'],width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                  subtitle: normalText(text: "${controller.snapshotData['email']}", color: golden),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: List.generate(
                        profileButtonIcons.length,
                            (index) => ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const ShopSettings());
                                break;
                              case 1:
                                Get.to(() => const MessagesScreen());
                                break;
                              default:

                            }
                          },
                          leading: Icon(
                            profileButtonIcons[index],
                            color: greenColor,
                          ),
                          title: normalText(text: profileButtonTitles[index]),
                        )),
                  ),
                )
              ],
            );
          }
      },)
    );
  }
}
