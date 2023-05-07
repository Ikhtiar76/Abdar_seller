import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/messages_screen/components/chat_bubble.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: chats,size: 20.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
              return chatBubble();
            },)),
            10.heightBox,
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    cursorColor: white,
                    style: const TextStyle(color: white),
                    decoration: const InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: white,
                          )
                      ),
                      hintText: 'Enter message ....',
                      hintStyle: TextStyle(color: white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: white,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: white,
                          )
                      ),
                    ),
                  )),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: golden,))
                ],
              ).box.padding(const EdgeInsets.symmetric(vertical: 5)).make()
            )
          ],
        ),
      ),
    );
  }
}

