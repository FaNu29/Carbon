import 'package:flutter/cupertino.dart';

class Clip1Clipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path =Path();

    path.lineTo(0,0);
    path.lineTo(0,size.height);
    path.quadraticBezierTo(size.width/2, size.height * 1.5,size.width,size.height);
    path.lineTo(size.width,0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
  return true;
  }

}

class TCircularContainer extends StatelessWidget{

  TCircularContainer({
    required this.width,
    required this.height,
    required this.radious,
    this.child,
    required this.backgroundColor
});

   final double width;
  final double height;
  final double radious;
  final Widget? child;
  final Color backgroundColor;



  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radious),
        color: backgroundColor
      ),
    child: child,
    );
  }
  
}