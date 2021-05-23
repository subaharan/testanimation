import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_animation/route/bottom_route.dart';
import 'package:flutter_test_animation/screens/splash.dart';
import 'package:flutter_test_animation/utils/Utils.dart';
import 'package:flutter_test_animation/utils/appcolor.dart';
import 'package:flutter_test_animation/utils/images.dart';
import 'package:flutter_test_animation/utils/size_config.dart';
import 'package:flutter_test_animation/utils/strings.dart';

import 'bottom_home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin<LoginPage> {
  bool isSignUp = false;
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  bool nameError = false, passwordError = false, emailError = false;
  bool signinEnable = false, signupEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: _decoration(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSignUp
                  ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              Utils.px_10 * SizeConfig.heightMultiplier),
                          child: IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                isSignUp = false;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Text(
                            Strings.back,
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
                  : new Container(),
              isSignUp ? Spacer() : new Container(),
              AnimatedSwitcher(
                switchOutCurve: Curves.bounceInOut,
                switchInCurve: Curves.elasticIn,
                duration: const Duration(microseconds: 1500),
                reverseDuration: const Duration(microseconds: 1500),
                child: isSignUp ? _signupTop() : _loginTop(),
              ),
              SizedBox(
                height: Utils.px_20 * SizeConfig.heightMultiplier,
              ),
              AnimatedSize(
                vsync: this,
                alignment: AlignmentDirectional.topCenter,
                duration: Duration(milliseconds: 1000),
                reverseDuration: Duration(milliseconds: 100),
                child: isSignUp ? _signupWidget() : _loginWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Utils.px_15 * SizeConfig.heightMultiplier,
              bottom: Utils.px_15 * SizeConfig.heightMultiplier),
          height: Utils.px_5 * SizeConfig.heightMultiplier,
          width: Utils.px_50 * SizeConfig.heightMultiplier,
          decoration: _lineBackground(),
        ),
        Container(
          margin:
              EdgeInsets.only(left: Utils.px_15 * SizeConfig.heightMultiplier),
          child: RichText(
            text: TextSpan(
                text: Strings.welcome,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Utils.px_20 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "\n${Strings.to_room_control}",
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.white,
                          fontSize: Utils.px_20 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.normal)),
                ]),
          ),
        ),
      ],
    );
  }

  Widget _signupTop() {
    return Container(
      margin: EdgeInsets.only(left: Utils.px_25 * SizeConfig.heightMultiplier),
      child: Text(
        Strings.create_new_account,
        style: TextStyle(
            fontSize: Utils.px_20 * SizeConfig.textMultiplier,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  loginValidate() {
    setState(() {
      if (userNameController.text.toString().length == 0) {
        nameError = true;
      } else {
        nameError = false;
      }

      if (userNameController.text.toString().length == 0) {
        passwordError = true;
      } else {
        passwordError = false;
      }

      if (userNameController.text.toString().length > 0 &&
          passwordController.text.length > 0) {
        signinEnable = true;
      } else {
        signinEnable = false;
      }
    });
  }

  signupValidate() {
    setState(() {
      if (userNameController.text.toString().length == 0) {
        nameError = true;
      } else {
        nameError = false;
      }

      if (userNameController.text.toString().length == 0) {
        passwordError = true;
      } else {
        passwordError = false;
      }

      if (Utils.validateEmail(emailController.text.toString())) {
        emailError = false;
      } else {
        emailError = true;
      }

      if (Utils.validateEmail(emailController.text.toString()) &&
          passwordController.text.length > 0 &&
          isCondition) {
        signupEnable = true;
      } else {
        signupEnable = false;
      }
    });
  }

  Widget _loginWidget() {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier),
            topRight:
                Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _nameWidget(),
          _passwordWidget(),
          GestureDetector(
            onTap: () {
              if (signinEnable) {
                startSplash(context);
              }
            },
            child: Container(
              margin: EdgeInsets.all(Utils.px_20 * SizeConfig.heightMultiplier),
              height: Utils.px_50 * SizeConfig.heightMultiplier,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                // Box decoration takes a gradient
                borderRadius: BorderRadius.circular(5),
                color: signinEnable ? AppColor.ff22A2AF : Colors.grey,
              ),
              child: Text(
                Strings.sign_in.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Utils.px_15 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: Utils.px_50 * SizeConfig.heightMultiplier,
                top: Utils.px_15 * SizeConfig.heightMultiplier),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Utils.px_15 * SizeConfig.heightMultiplier),
                children: <TextSpan>[
                  TextSpan(
                    text: Strings.dont_have_account,
                  ),
                  TextSpan(
                      text: "\t${Strings.sign_up.toUpperCase()}",
                      style: TextStyle(
                          color: AppColor.ff22A2AF,
                          fontSize: Utils.px_15 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isSignUp = true;
                          });
                        }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _nameWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Utils.px_25 * SizeConfig.heightMultiplier,
          vertical: Utils.px_15 * SizeConfig.heightMultiplier),
      child: TextField(
        controller: userNameController,
        onChanged: (value) {
          if (isSignUp) {
            signupValidate();
          } else {
            loginValidate();
          }
        },
        decoration: InputDecoration(
            errorText: nameError ? Strings.invalid_username : null,
            // border: OutlineInputBorder(),
            icon: new Icon(
              Icons.perm_identity,
              color: Colors.black87,
            ),
            labelText: Strings.username,
            hintText: Strings.enter_username),
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Utils.px_25 * SizeConfig.heightMultiplier,
          vertical: Utils.px_5 * SizeConfig.heightMultiplier),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        onChanged: (value) {
          if (isSignUp) {
            signupValidate();
          } else {
            loginValidate();
          }
        },
        decoration: InputDecoration(
            errorText: passwordError ? Strings.invalid_password : null,
            // border: OutlineInputBorder(),
            icon: new Icon(
              Icons.work_outline,
              color: Colors.black87,
            ),
            labelText: Strings.password,
            hintText: Strings.enter_password),
      ),
    );
  }

  Widget _emailWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Utils.px_25 * SizeConfig.heightMultiplier,
          vertical: Utils.px_15 * SizeConfig.heightMultiplier),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        onChanged: (value) {
          signupValidate();
        },
        decoration: InputDecoration(
            errorText: emailError ? Strings.invalid_emailid : null,
            // border: OutlineInputBorder(),
            icon: new Icon(
              Icons.email_outlined,
              color: Colors.black87,
            ),
            labelText: Strings.emailid,
            hintText: Strings.enter_emailid),
      ),
    );
  }

  bool isCondition = false;

  Widget _signupWidget() {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier),
            topRight:
                Radius.circular(Utils.px_30 * SizeConfig.heightMultiplier)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Utils.px_40 * SizeConfig.heightMultiplier,
          ),
          _nameWidget(),
          _passwordWidget(),
          _emailWidget(),
          SizedBox(
            height: Utils.px_30 * SizeConfig.heightMultiplier,
          ),
          CheckboxListTile(
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Utils.px_13 * SizeConfig.heightMultiplier),
                children: <TextSpan>[
                  TextSpan(
                    text: "${Strings.i_accepted_the}\t",
                  ),
                  TextSpan(
                      text: "${Strings.terms_condition}",
                      style: TextStyle(
                          color: AppColor.ff22A2AF,
                          fontSize: Utils.px_13 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ],
              ),
            ),
            value: isCondition,
            onChanged: (newValue) {
              setState(() {
                isCondition = newValue;
                signupValidate();
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
          SizedBox(
            height: Utils.px_10 * SizeConfig.heightMultiplier,
          ),
          GestureDetector(
            onTap: () {
              if (signupEnable) {
                startSplash(context);
              }
            },
            child: Container(
              margin: EdgeInsets.all(Utils.px_20 * SizeConfig.heightMultiplier),
              height: Utils.px_50 * SizeConfig.heightMultiplier,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                // Box decoration takes a gradient
                borderRadius: BorderRadius.circular(5),
                color: signupEnable ? AppColor.ff22A2AF : Colors.grey,
              ),
              child: Text(
                Strings.sign_up.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Utils.px_15 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Spacer()
          SizedBox(
            height: Utils.px_40 * SizeConfig.heightMultiplier,
          ),
        ],
      ),
    );
  }

  //------------------
  BoxDecoration _decoration() {
    // Add box decoration signup_bg
    return BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(
              isSignUp ? Images.signup_bg: Images.login_bg),
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
}

//------------------
BoxDecoration _lineBackground() {
  // Add box decoration
  return BoxDecoration(
    // Box decoration takes a gradient
    borderRadius:
        BorderRadius.circular(Utils.px_5 * SizeConfig.heightMultiplier),
    color: Colors.white,
  );
}

//---------------
Future startHome(BuildContext context) async {
  Navigator.pushReplacement(context, BottomRoute(widget: BottomHome()));
}

//---------------
Future startSplash(BuildContext context) async {
  Navigator.pushReplacement(context, BottomRoute(widget: SplashWidget()));
}
