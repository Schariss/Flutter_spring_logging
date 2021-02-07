import 'dart:convert';

import 'package:Auth_spring/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  double _height = 670.0;
  bool islogged = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String url = "http://ipAdress:8080/login";
  Map<String, dynamic> decodedToken;
  Future<String> _token;

  //verify email and password
  // void login() async {
  //   var res = await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({'email': email.text, 'password': password.text}));
  //   print('status code : ${res.statusCode}');
  //   print(res);
  //   if (res.body != "") {
  //     print('logged in');
  //     setState(() => islogged = true);
  //     _formkey.currentState.reset();
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Dashboard()));
  //   } else {
  //     setState(() => islogged = false);
  //   }
  // }

  //login with JWT
  //using the conerence api
  //login with username and password : JWTAuthorizationFilter, JWT AuthenticationFilter in springboot
  void login() async {
    var res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'username': email.text, 'password': password.text}));
    print('status code : ${res.statusCode}');
    print(res);
    if (res.statusCode == 200) {
      print('logged in');
      print(res.headers['authorization']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = res.headers['authorization'];
      setState(() {
        _token = prefs.setString("token", token).then((bool success) {
          return _token;
        });
        print(_token);
        print("get token from local Strorage ${prefs.getString('token')}");
      });
      // bool isTokenExpired = JwtDecoder.isExpired(token);
      // DateTime expirationDate = JwtDecoder.getExpirationDate(token);
      // Duration tokenTime = JwtDecoder.getTokenTime(token);
      decodedToken = JwtDecoder.decode(token);
      print('-----------------------------');
      print(decodedToken);
      setState(() => islogged = true);
      _formkey.currentState.reset();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      print('wrong credentials');
      setState(() => islogged = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            height: _height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black, offset: Offset(1, 5))
                ],
                color: Color.fromRGBO(233, 65, 82, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text('Login',
                      style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white)),
                  SizedBox(
                    height: 70,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
                      )),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _height = 700;
                        });
                        return 'Email is Empty';
                      }
                      // else if (!value.contains('@')) {
                      //   return "must contains @";
                      // }
                      else {
                        return null;
                      }
                    },
                    controller: email,
                    // onChanged: (val){
                    //   user.email = val;
                    // },
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
                        hintText: "abc@g.com",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.4)),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  Container(
                    height: 4,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Password',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
                      )),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _height = 700;
                        });
                        return 'password is Empty';
                      }
                      // else if (value.length < 6) {
                      //   return 'must have 6 or more characters';
                      // }
                      else {
                        return null;
                      }
                    },
                    controller: password,
                    obscureText: true,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
                        hintText: "pass",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.4)),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                  Container(
                    height: 4,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      'Don\'t have an account ? Register',
                      style: GoogleFonts.roboto(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          !islogged
              ? Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "Wrong Credentials",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Text(""),
          SizedBox(
            height: 40,
          ),
          Container(
              height: 70,
              width: 70,
              child: FlatButton(
                  color: Color.fromRGBO(233, 65, 82, 1),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      login();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Icon(Icons.arrow_forward,
                      size: 30, color: Colors.white))),
        ],
      ),
    )));
  }
}
