import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const MyButton({super.key,
    required this.onTap,
    required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30)
                )
            ),
            color: Color(0xFF455932),
          ) ,
          child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
            ),
          ),

        ),
      ),
    );
  }
}
