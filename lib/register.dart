import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  MaterialColor primaryColor = Colors.orange;
  double _height = 670.0;
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String url = "http://ipAdress:8080/register";

  void register() async {
    var res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'email': email.text, 'password': password.text}));
    print('status code : ${res.statusCode}');
    print('response is : ${res.body}');
    if (res.body != null) {
      _formkey.currentState.reset();
      Navigator.pop(context);
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
                color: primaryColor,
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
                  Text('Register',
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
                          _height = 690;
                        });

                        return 'Email is Empty';
                      } else {
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
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
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
                        return 'password is Empty';
                      } else {
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
                        hintText: "six or more letters",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.9)),
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Already have an account, login',
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
          SizedBox(
            height: 60,
          ),
          Container(
              height: 70,
              width: 70,
              child: FlatButton(
                  color: primaryColor,
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      register();
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
