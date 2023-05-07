import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';

Widget myButton({title, color = greenColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12)
    ),
      onPressed: onPress, child: boldText(text: title, size: 16.0));
}
