
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_animation/route/bottom_route.dart';
import 'package:flutter_test_animation/screens/detail_page.dart';
import 'package:flutter_test_animation/utils/appcolor.dart';
import 'package:flutter_test_animation/utils/images.dart';
import 'package:flutter_test_animation/utils/size_config.dart';
import 'package:flutter_test_animation/utils/strings.dart';
import 'package:flutter_test_animation/utils/utils.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeWidgetState extends State<HomeWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _decoration(),
        child: SafeArea(
          child: Container(

            child: Column(
              children: [
                _profile(),
                _mainWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _mainWidget(BuildContext context) {
  return Flexible(
    fit: FlexFit.tight,
    child: Card(
      margin: EdgeInsets.all(0),
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier),
            topRight:
            Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Utils.px_20 * SizeConfig.heightMultiplier,
          ),
          _title(),
          SizedBox(
            height: Utils.px_20 * SizeConfig.heightMultiplier,
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: (){
                    startDetailPage(context, Strings.living_room, 2);
                  },
                    child: _cardWidget(Strings.bed_room,  4, Images.bed, true))),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                        onTap: (){

                        },child: _cardWidget(Strings.living_room, 2, Images.room, false))),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                        onTap: (){

                        },child: _cardWidget(Strings.kitchen,  5, Images.kitchen, true))),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                        onTap: (){

                        },child: _cardWidget(Strings.bathroom, 1, Images.bathtube, false))),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                        onTap: (){

                        },child: _cardWidget(Strings.outdoor, 5, Images.house, true))),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                        onTap: (){

                        },child: _cardWidget(Strings.balcony, 2, Images.balcony, false))),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


//------------------
Widget _title(){
  return Padding(padding: EdgeInsets.symmetric(horizontal: Utils.px_15 * SizeConfig.heightMultiplier),
  child: Text(
    Strings.all_rooms,
    style: TextStyle(
        fontSize:
        Utils.px_18 * SizeConfig.textMultiplier,
        color: AppColor.ff133746,
        decoration: TextDecoration.none,
        fontWeight: FontWeight.normal),
  ),);
}


//------------------
Widget _cardWidget(String title, int count, String image, bool side){
  return   Padding(
      padding: side?EdgeInsets.only(left:Utils.px_15 * SizeConfig.heightMultiplier,
          bottom: Utils.px_15 * SizeConfig.heightMultiplier,
          right:Utils.px_7 * SizeConfig.heightMultiplier):EdgeInsets.only(left:Utils.px_7 * SizeConfig.heightMultiplier,
          bottom: Utils.px_15 * SizeConfig.heightMultiplier,
          right:Utils.px_15 * SizeConfig.heightMultiplier),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 8,

        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Utils.px_15 * SizeConfig.heightMultiplier)),
        ),
        child: Padding(
          padding: EdgeInsets.all(Utils.px_15 * SizeConfig.heightMultiplier),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                image,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: AppColor.ff133746,
                      fontSize: Utils.px_15 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${title}\n",
                    ),
                    TextSpan(
                        text: "$count\t${Strings.lights}",
                        style: TextStyle(
                            color: Colors.amber,
                            height: 1.5,
                            fontSize: Utils.px_13 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}

//------------------
Widget _profile(){
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: Utils.px_10 * SizeConfig.heightMultiplier, horizontal: Utils.px_20 * SizeConfig.heightMultiplier),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.control_panel,
          style: TextStyle(
              fontSize:
              Utils.px_25 * SizeConfig.textMultiplier,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(Images.user),
        ),
      ],
    ),
  );
}
//------------------
BoxDecoration _decoration() {
  // Add box decoration signup_bg
  return BoxDecoration(
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
Future startDetailPage(BuildContext context, String title, int count) async {
  Navigator.push(context, BottomRoute(widget: DetailPage(title: title, count: count,)));
}