import 'package:flutter/material.dart';

class CircleDesign extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*1.154599,size.height*0.2495470);
    path_0.cubicTo(size.width*1.157300,size.height*0.2347051,size.width*1.158690,size.height*0.2196013,size.width*1.158690,size.height*0.2042834);
    path_0.cubicTo(size.width*1.158690,size.height*-0.004984333,size.width*0.8993073,size.height*-0.1746293,size.width*0.5793451,size.height*-0.1746293);
    path_0.cubicTo(size.width*0.2593829,size.height*-0.1746293,0,size.height*-0.004984333,0,size.height*0.2042834);
    path_0.cubicTo(0,size.height*0.3879605,size.width*0.1998242,size.height*0.5411137,size.width*0.4650479,size.height*0.5758237);
    path_0.cubicTo(size.width*0.4623476,size.height*0.5906656,size.width*0.4609572,size.height*0.6057694,size.width*0.4609572,size.height*0.6210873);
    path_0.cubicTo(size.width*0.4609572,size.height*0.8303558,size.width*0.7203401,size.height,size.width*1.040302,size.height);
    path_0.cubicTo(size.width*1.360267,size.height,size.width*1.619647,size.height*0.8303558,size.width*1.619647,size.height*0.6210873);
    path_0.cubicTo(size.width*1.619647,size.height*0.4374102,size.width*1.419824,size.height*0.2842570,size.width*1.154599,size.height*0.2495470);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color.fromARGB(255, 226, 236, 255).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}



  Color kPrimaryColor2 = const Color.fromARGB(255, 30, 27, 180);
  Color kPrimaryColor1 = const Color.fromARGB(255, 28, 81, 227);