import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/services/store_services.dart';
import 'package:abdar_seller/views/messages_screen/chat_screen.dart';
import 'package:abdar_seller/views/widgets/loading.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: boldText(text: messages, size: 20.0),
        ),
        body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(
                          data.length,
                          (index){
                            var t = data[index]['created_on'] == null ? DateTime.now(): data[index]['created_on'].toDate();
                            var time = intl.DateFormat('h:mma').format(t);
                            return ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                onTap: () {
                                  Get.to(() => const ChatScreen());
                                },
                                tileColor: tileColor,
                                leading: const CircleAvatar(
                                  backgroundColor: greenColor,
                                  child: Icon(
                                    Icons.person,
                                    color: white,
                                  ),
                                ),
                                title: boldText(
                                    text: '${data[index]['senderName']}'),
                                subtitle: normalText(
                                    text: '${data[index]['last_msg']}',
                                    color: darkGrey),
                                trailing: normalText(text: time),
                              )
                                  .box
                                  .rounded
                                  .margin(const EdgeInsets.only(bottom: 5))
                                  .make();})),
                ),
              );
            }
          },
        ));
  }
}
