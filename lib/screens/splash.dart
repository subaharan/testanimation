import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_animation/route/bottom_route.dart';
import 'package:flutter_test_animation/utils/appcolor.dart';
import 'package:flutter_test_animation/utils/images.dart';
import 'package:flutter_test_animation/utils/size_config.dart';
import 'package:flutter_test_animation/utils/strings.dart';
import 'package:flutter_test_animation/utils/utils.dart';

import 'bottom_home.dart';

class SpinningContainer extends AnimatedWidget {
  const SpinningContainer({
    Key key,
    @required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(

      angle: _progress.value * 2.0 * math.pi,
      child: SvgPicture.asset(
        Images.spiner,
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class SplashWidget extends StatefulWidget {
  const SplashWidget({Key key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<SplashWidget> with TickerProviderStateMixin<SplashWidget> {
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      lowerBound: 1.5,
      upperBound: 3,
      animationBehavior: AnimationBehavior.preserve,
      reverseDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    new Future.delayed(const Duration(seconds: 2), () {
      startHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _decoration(),
        child: Column(
          children: [
            Spacer(),
            SpinningContainer(controller: _controller),
            Container(
              margin: EdgeInsets.only(bottom: Utils.px_150 * SizeConfig.heightMultiplier, top: Utils.px_20 * SizeConfig.heightMultiplier),
              child: Text(
                Strings.let_get_started,
                style: TextStyle(
                    fontSize:
                    Utils.px_16 * SizeConfig.textMultiplier,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        )
    );
  }
}

//------------------
BoxDecoration _decoration() {
  // Add box decoration signup_bg
  return BoxDecoration(
    image: new DecorationImage(
        image: new AssetImage(Images.splash_bg),
        alignment: Alignment.topRight
      // fit: BoxFit.fill,
    ),
    gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0.1, 0.7],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        AppColor.ff133746,
        AppColor.ff30708A,
      ],
    ),
  );
}

//---------------
Future startHome(BuildContext context) async {
  Navigator.pushReplacement(context, BottomRoute(widget: BottomHome()));
}

//---------------
Future startSplash(BuildContext context) async {
  Navigator.pushReplacement(context, BottomRoute(widget: BottomHome()));
}