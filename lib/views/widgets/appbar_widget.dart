import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBarWidget(title){
  return AppBar(
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: white, size: 20.0),
    actions: [
      Center(
          child: normalText(
              text: intl.DateFormat('EEE, MMM d, ' 'yy')
                  .format(DateTime.now()),
              color: greenColor)),
      15.widthBox
    ],
  );
}