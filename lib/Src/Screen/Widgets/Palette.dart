import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

class ColorPalette extends HookWidget{
  final ValueNotifier<Color> selectedColor;

  const ColorPalette({
    Key? key,
    required this.selectedColor,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.black,
      Colors.white,
      Color(0xffEE2AA9),
      Color(0xffEDFF36),
      Color(0xffA689C4),
      Color(0xffFF99D9),
      //Color(0xff36333E),
      ...Colors.primaries,
      ...Colors.accents,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 2,
          runSpacing: 2,
          children: [
            for(Color color in colors)
              GestureDetector(
                onTap: (){
                  selectedColor.value = color;
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: selectedColor.value == color
                        ? Colors.deepPurple
                        : Colors.grey,
                      width: 1.5
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: selectedColor.value,
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
            ),
            const SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                showColorWheel(context,selectedColor);
              },
              child: SvgPicture.asset(
                'Material/color_wheel.svg',
                height: 30,
                width: 30,
              ),
            )
          ],
        )
      ],
    );
  }
  showColorWheel(BuildContext context,ValueNotifier<Color> color){
    showDialog(
      //barrierColor: Color(0xff767E91),
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Color(0xff767E91),
          /*title: const Text(
            'Pick A Color Here!',
            textAlign: TextAlign.end,
          ),*/
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerAreaBorderRadius: BorderRadius.all(Radius.circular(200),),
              pickerColor: color.value,
              onColorChanged: (value){
                color.value = value;
              },
            ),
          ),
         /* actions: <Widget>[
            TextButton(
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              onPressed: (){
                return Navigator.pop(context);
              },
            )
          ],*/
        );
      }
    );
  }
}