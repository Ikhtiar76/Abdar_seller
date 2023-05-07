import 'package:abdar_seller/const/const.dart';
import 'package:abdar_seller/views/widgets/text_style.dart';

Widget customTextField({label,hint,controller, isDesc = false}){
  return TextFormField(
    controller: controller,
    cursorColor: white,
    maxLines: isDesc? 4:1,
    style: const TextStyle(color: white),
    decoration: InputDecoration(
      isDense: true,
        label: normalText(text: label),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
            color: white
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white
        ),
      ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: golden
            ),
          ),
          hintText: hint,
      hintStyle: const TextStyle(
        color: white
      )
    ),
  );
}