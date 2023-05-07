import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
Widget orderPlaceDetails({title1,title2,d1,d2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: '$title1',color: white),
            boldText(text: '$d1',color: golden),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: '$title2',color: white),
              boldText(text: '$d2',color: golden),
            ],
          ),
        )
      ],
    ),
  );
}
