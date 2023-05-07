import 'package:abdar_seller/const/const.dart';

Widget productImages({label, onPress}){
  return '$label'.text.bold.size(20.0).makeCentered().box.white.size(100, 100).roundedSM.make();
}