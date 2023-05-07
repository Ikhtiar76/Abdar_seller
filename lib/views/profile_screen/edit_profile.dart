import 'dart:io';

import 'package:abdar_seller/Controllers/profile_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/custom_textfield.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/my_button.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key,this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        appBar: AppBar(
          title: boldText(text: editProfile,size: 20.0),
          actions: [
            controller.isLoading.value? loadingIndicator() : TextButton(onPressed: ()async{
              controller.isLoading(true);

              //if img is not selected
              if(controller.profileImagePath.value.isNotEmpty){
                await controller.uploadProfileImage();
              }else{
                controller.profileImageLink = controller.snapshotData['imgUrl'];
              }

              //if old pass matches data base
              if(controller.snapshotData['password'] == controller.oldPasswordController.text){

                await controller.changeAuthPassword(
                    email: controller.snapshotData['email'],
                    password: controller.oldPasswordController.text,
                    newpassword: controller.newPasswordController.text
                );


                await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.newPasswordController.text
                );
                VxToast.show(context, msg: 'Updated');
              }else if(controller.oldPasswordController.text.isEmptyOrNull && controller.newPasswordController.text.isEmptyOrNull){
                await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.snapshotData['password']);
                VxToast.show(context, msg: 'Updated');
              }
              else{
                VxToast.show(context, msg: 'Some error occured');
                controller.isLoading(false);
              }

            }, child: normalText(text: save,size: 20.0,color: greenColor),),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                controller.snapshotData['imgUrl']=='' && controller.profileImagePath.isEmpty
                    ? Image.asset(
                  imgProduct,
                  width: 80,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
                    :

                //if data img url is not empty but controller path is empty
                controller.snapshotData['imgUrl']!='' && controller.profileImagePath.isEmpty?
                Image.network(controller.snapshotData['imgUrl'],width: 80,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() :

                // if both are empty
                Image.file(
                  File(controller.profileImagePath.value),
                  width: 80,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                //Image.asset(imgProduct,width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                myButton(title: changeImage,color: greenColor,onPress: (){
                  controller.changeImage(context);
                },),
                10.heightBox,
                const Divider(
                  color: greenColor,
                ),
                10.heightBox,
                customTextField(label: name,hint: nameHint,controller: controller.nameController),
                20.heightBox,
                Align(alignment:Alignment.centerLeft,child: boldText(text: 'Change your password',color: golden,size: 18.0)),
                5.heightBox,
                customTextField(label: password,hint: passwordHint,controller: controller.oldPasswordController),
                10.heightBox,
                customTextField(label: confirmPass,hint: passwordHint,controller: controller.newPasswordController),
              ],
            ),
        ),
      ),
    );
  }
}
