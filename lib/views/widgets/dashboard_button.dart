import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';

Widget dashBoardButton(context,{title,count,icon}){
  var size = MediaQuery.of(context).size;

  return Row(
    children: [
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldText(text: title,size: 16.0,color: golden),
          boldText(text: count,size: 20.0,color: lightGrey),
        ],
      )),
      Image.asset(icon,color: darkGrey,width: 40,)
    ],
  ).box.color(tileColor).rounded.size(size.width*0.4, 80).padding(const EdgeInsets.all(8)).make();
}
