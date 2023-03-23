import 'package:flutter/material.dart';
import 'dart:math';

import '../widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,

    );
    catAnimation = Tween(begin: -40.0, end: -160.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));

    boxAnimation = Tween(begin: 0.5, end: 0.6).animate(CurvedAnimation(
      parent: boxController,
      curve: Curves.easeInOut,
    ));
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();



  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
          child: child!,
        );
      },
      child: const Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: pi * boxAnimation.value,
            child: child!,
          );
        },
      ),
    );
  }
  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.brown,
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -(pi * boxAnimation.value),
            child: child!,
          );
        },
      ),
    );
  }
}
