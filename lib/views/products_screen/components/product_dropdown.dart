import 'package:abdar_seller/Controllers/products_controller.dart';
import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(hint,List<String>list,dropValue,ProductsController controller){
  return Obx(()=> DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: '$hint',color: Vx.black),
          isExpanded: true,
          value: dropValue.value == '' ? null:dropValue.value,
          items: list.map((e){
            return DropdownMenuItem(
                value: e,
                child: e.toString().text.make(),
            );
          }).toList(), onChanged: (newValue){
          if(hint == 'Category'){
            controller.subcategoryValue.value = '';
            controller.populateSubcategoryList(newValue.toString());
          }
          dropValue.value = newValue.toString();
      }).box.color(white).roundedSM.padding(const EdgeInsets.all(5)).make(),
    ),
  );
}