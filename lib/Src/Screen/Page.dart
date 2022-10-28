import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_draw/Src/Screen/Canvas.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_draw/Src/Service/Model/Model.dart';
import 'package:flutter_draw/Src/Service/Model/Sketch.dart';
import 'package:flutter_draw/main.dart';
import './Widgets/Palette.dart';
import './Widgets/Sidebar.dart';

class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;

  const _CustomAppBar({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight+10,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10
        ),
        child: MediaQuery.of(context).size.height < 680
          ?Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){
                if(animationController.value == 0){
                  animationController.forward();
                }else{
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu,color: Color(0xff767E91),),
            ),
            /*const Text(
              'Let\`s Draw',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Colors.grey,
              ),
            ),*/
            const SizedBox.shrink(),
          ],
        ):Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){
                if(animationController.value == 0){
                  animationController.forward();
                }else{
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu,color: Color(0xff767E91),size: 60,),
            ),
          ],
        )
      ),
    );
  }
}

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);
    final canvasGlobalKey = GlobalKey();
    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kCanvasColor,
            height: double.maxFinite,
            width: double.maxFinite,
            child: DrawingCanvas(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              sideBarController: animationController,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
              filled: filled,
              polygonSides: polygonSides,
              backgroundImage: backgroundImage,
            ),
          ),
          Positioned(
            top: kToolbarHeight + 10,
            // left: -5,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animationController),
              child: CanvasSideBar(
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
              ),
            ),
          ),
          _CustomAppBar(animationController: animationController),
        ],
      ),
    );
  }
}
