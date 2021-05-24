import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_animation/model/light_obj.dart';
import 'package:flutter_test_animation/utils/appcolor.dart';
import 'package:flutter_test_animation/utils/images.dart';
import 'package:flutter_test_animation/utils/size_config.dart';
import 'package:flutter_test_animation/utils/strings.dart';
import 'package:flutter_test_animation/utils/utils.dart';

class DetailPage extends StatefulWidget {
int count;
String title;

  DetailPage(
      {Key key,
        @required this.count,
        @required this.title})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin{
  int sliderValue = 100;
int colorIndex=0;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  static const List<MaterialColor> colorList = <MaterialColor>[
    Colors.purple,
    Colors.green,
    Colors.deepPurple,
    Colors.indigo,
    Colors.amber,
    Colors.orange,
    Colors.cyan,
  ];

  static List<LightObj> lightData= new List();
Future<void> addLightdata() async {
  LightObj item1= new LightObj(image: Images.bright_bulb, title: Strings.main_light);
  LightObj item2= new LightObj(image: Images.desk, title: Strings.desk_light);
  LightObj item3= new LightObj(image: Images.bed_light, title: Strings.bed_light);
  setState(() {
    lightData.add(item1);
    lightData.add(item2);
    lightData.add(item3);
  });

  await new Future.delayed(Duration(seconds: 1), (){
   _controller.forward();
  });

}
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
        .animate(_controller);

    addLightdata();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

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
                SizedBox(height: Utils.px_15 * SizeConfig.heightMultiplier,),
                lightData==null?Container():SlideTransition(position: _offsetFloat,
                child: _lightListView()
                ),
                SizedBox(height: Utils.px_20 * SizeConfig.heightMultiplier,),
                _mainWidget()
              ],
            ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back, color: Colors.white,),
            ),
          ),
          SizedBox(width: Utils.px_5 * SizeConfig.heightMultiplier,),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontSize:
                  Utils.px_25 * SizeConfig.textMultiplier,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: "${widget.title}\n",
                ),
                TextSpan(
                  text: "${widget.count}\t${Strings.lights}",
                  style: TextStyle(
                      color: Colors.amber,
                      height: 2,
                      fontSize: Utils.px_15 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),

          Spacer(),
          Container(

            child: Icon(Icons.lightbulb, color: colorList[colorIndex][900-sliderValue],
            size: Utils.px_60 * SizeConfig.heightMultiplier,),
          ),
        ],
      ),
    );
  }

//------------------
  Widget _mainWidget() {
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: Utils.px_5 * SizeConfig.heightMultiplier,
            ),
            _title(Strings.intensity),
            _sliderWidget(),
            SizedBox(
              height: Utils.px_5 * SizeConfig.heightMultiplier,
            ),
            _title(Strings.colors),
            _colorListView(),
            SizedBox(
              height: Utils.px_5 * SizeConfig.heightMultiplier,
            ),
            _title(Strings.scenes),
            Container(

              child: Row(
                children: [
                  _sceneWidget(Colors.orange,  Strings.birthday, true),
                  _sceneWidget(Colors.purple, Strings.party,false),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  _sceneWidget(Colors.lightBlue,  Strings.relax, true),
                  _sceneWidget(Colors.lightGreen, Strings.fun,false),
                ],
              ),
            ),
            SizedBox(
              height: Utils.px_5 * SizeConfig.heightMultiplier,
            ),
          ],
        ),
      ),
    );
  }



  //------------------
  Widget _sceneWidget( MaterialColor color1, String title, bool side){
    return Flexible(
        flex: 1,
        child: Padding(
          padding: side?EdgeInsets.only(left:Utils.px_15 * SizeConfig.heightMultiplier,
            bottom: Utils.px_15 * SizeConfig.heightMultiplier,
            right:Utils.px_7 * SizeConfig.heightMultiplier):EdgeInsets.only(left:Utils.px_7 * SizeConfig.heightMultiplier,
        bottom: Utils.px_15 * SizeConfig.heightMultiplier,
        right:Utils.px_15 * SizeConfig.heightMultiplier),
          child: Container(
            height: Utils.px_60 * SizeConfig.heightMultiplier,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.bright_bulb,
                  color: Colors.white,
                ),
                SizedBox(
                  width: Utils.px_20 *SizeConfig.heightMultiplier,
                ),
                Text(title,
                  style: TextStyle(
                      fontSize:
                      Utils.px_15 * SizeConfig.textMultiplier,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(Utils.px_15 * SizeConfig.heightMultiplier),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.7],
                colors: [color1, color1[600],
                ],
              ),
            ),
          ),
        ));
  }

  //------------------
  Widget _colorListView() {
    return SizedBox(
      height: Utils.px_40 * SizeConfig.heightMultiplier,
      child: ListView.builder(
        padding: EdgeInsets.only(left: Utils.px_10 * SizeConfig.heightMultiplier, right: Utils.px_10 * SizeConfig.heightMultiplier),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          
          return Padding(
            padding: EdgeInsets.only(left: Utils.px_5 * SizeConfig.heightMultiplier),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  if(index<colorList.length) {
                    colorIndex = index;
                  }
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  height: Utils.px_40* SizeConfig.heightMultiplier,
                  width: Utils.px_40* SizeConfig.heightMultiplier,
                  color: index==colorList.length?Colors.white60:colorList[index],
                  child: index==colorList.length?FloatingActionButton(onPressed: null,
                  backgroundColor: Colors.white,
                  mini: true,
                  elevation: 9,

                  child: Icon(Icons.add, color: Colors.black87,),):null,
                ),
              ),
            ),
          );

        },
        itemCount: colorList.length+1,
      ),
    );
  }

  //------------------
  Widget _lightListView() {

    return SizedBox(
      height: Utils.px_60 * SizeConfig.heightMultiplier,
      child: ListView.builder(
        padding: EdgeInsets.only(left: Utils.px_10 * SizeConfig.heightMultiplier, right: Utils.px_10 * SizeConfig.heightMultiplier),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {

          return Card(
            margin: EdgeInsets.only(left: Utils.px_10 * SizeConfig.heightMultiplier),
            elevation: 8,
            color: index==1?AppColor.ff30708A:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Utils.px_15 * SizeConfig.heightMultiplier)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Utils.px_15 * SizeConfig.heightMultiplier, horizontal: Utils.px_10 * SizeConfig.heightMultiplier),
              child: GestureDetector(
                onTap: (){

                },
                child: Container(

                  height: Utils.px_60 * SizeConfig.heightMultiplier,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        lightData[index].image,
                        color: index==1?Colors.white:AppColor.ff30708A,
                      ),
                      SizedBox(
                        width: Utils.px_20 *SizeConfig.heightMultiplier,
                      ),
                      Text(lightData[index].title,
                        style: TextStyle(
                            fontSize:
                            Utils.px_15 * SizeConfig.textMultiplier,
                            color: index==1?Colors.white:AppColor.ff30708A,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          );

        },
        itemCount: lightData.length,
      ),
    );
  }

  //------------------
  Widget _sliderWidget(){
    return Row(
      children: [
        SizedBox(width: Utils.px_20 * SizeConfig.heightMultiplier,),
        SvgPicture.asset(
          Images.normal_bulb,
        ),

        Expanded(
          child: Slider.adaptive(
              value: sliderValue.toDouble(),
              min: 0.0,
              max: 800.0,
              divisions: 100,
              activeColor: Colors.amber,
              inactiveColor: Colors.grey,
              label: 'Set volume value',
              onChanged: (double newValue) {
                setState(() {

                  sliderValue = calculateNumber(newValue.round().toInt());

                  print("value ${sliderValue}");
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()} dollars';
              }
          ),
        ),
        SvgPicture.asset(
          Images.bright_bulb,
          color: Colors.amber,
        ),
        SizedBox(width: Utils.px_20 * SizeConfig.heightMultiplier,),
      ],
    );
  }

  int calculateNumber(int number) {
    int a = number % 100;
    if (a > 0) {
      return (number ~/ 100) * 100 + 100;
    }
    return number;
  }

  //------------------
  Widget _title(String data){
    return Padding(padding: EdgeInsets.symmetric(horizontal: Utils.px_15 * SizeConfig.heightMultiplier, vertical: Utils.px_10 * SizeConfig.heightMultiplier),
      child: Text(data,
        style: TextStyle(
            fontSize:
            Utils.px_18 * SizeConfig.textMultiplier,
            color: AppColor.ff133746,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
      ),);
  }
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