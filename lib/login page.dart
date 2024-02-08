import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as https;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var timezone;
  var week_number;
  var day_of_year;
  var day_of_week;
  var datetime;
  var parsingDateTime;
  bool isLoading  = false;
  var error = "";

  Future<void> getTime() async{

    try{
      var dio = Dio();
      final response = await dio.get('https://worldtimeapi.org/api/timezone/Europe/london');
      print(response.data);
      // Await the http get response, then decode the json-formatted response.
      if (response.statusCode == 200) {
        print("***************************************************************************");
        timezone = response.data['timezone'];
        week_number = response.data['week_number'];
        day_of_year = response.data['day_of_year'];
        day_of_week = response.data['day_of_week'];
        datetime = response.data['datetime'];
        parsingDateTime = DateFormat.jm().format(DateTime.parse(datetime));
        error = 'Sucseessfully';
      } else {
        print('Request failed with status: ${response.statusCode}.');
        error = 'Request failed with status: ${response.statusCode}';
      }

    }
    catch(e){
      print("failed");
      error = "failed";
    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Container(
          width: 500.0,
          height: 500.0,

          child: Padding(
            padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 00.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Text("London !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Time Zone',
                      hintText: '$timezone',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1F5753)),
                      ),

                    ),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Week Number',
                      hintText: '$week_number',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1F5753)),
                      ),

                    ),
                  ),
                  SizedBox(height: 2.0),

                  TextField(
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Day of Year',
                      hintText: '$day_of_year',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1F5753)),
                      ),

                    ),
                  ),
                  SizedBox(height: 2.0),

                  TextField(
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Day of Week',
                      hintText: '$day_of_week',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1F5753)),
                      ),

                    ),
                  ),
                  SizedBox(height: 2.0),
                  TextField(
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      labelText: 'Date Time',
                      hintText: '$parsingDateTime',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF1F5753)),
                      ),

                    ),
                  ),
                  SizedBox(height: 10.0),

                  GestureDetector(
                    /*onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                    },*/
                    child: new Text("$error",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),

                  ),
                  SizedBox(height: 2.0),
                     Visibility(
                       visible: isLoading,
                       child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: Colors.purple,
                          strokeWidth: 10,
                        )
                  ),
                     ),

                  MaterialButton(
                    onPressed: () {

                      setState(() {
                        isLoading = true;
                        print("*************************************************");
                        getTime().whenComplete(
                                (){
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Text("$error"),
                                    );
                                  });
                                }
                        );
                        print("*************************************************");
                      });
                     // Get.to(homeScreen());
                      //Get.off(add_new_property_1());
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: Color(0xFF1F5753),
                    child: SizedBox(width: 30.0,height: 20.0,
                      child: Center(
                        child : Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),


    );
  }
}


