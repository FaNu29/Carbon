import 'package:flutter/material.dart';

class TextFieldInpute extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validate;
  final TextInputType textInputType;

   TextFieldInpute({super.key,
    required this.textEditingController,
    required this.isPass,
    required this.validate,
    required this.hintText,
    required this.icon,
    required this.textInputType
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: validate,
        keyboardType: textInputType,
        obscureText: isPass ,
        controller: textEditingController,
        decoration: InputDecoration(

          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 14
          ),
          prefixIcon: Icon(icon,
            color: Colors.black45
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFedf0f8),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
              borderRadius:BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30)
              )

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2,
                color:Color(0xFF455932)),
              borderRadius:BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30)
              )
          )

        ),
      ),
    );
  }
}


