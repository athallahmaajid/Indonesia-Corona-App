import 'package:corona_app/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 141, 211, 95),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/15, MediaQuery.of(context).size.height/15, 0, 0),
              child: Text("Welcome", style: TextStyle(fontFamily: "Damion", fontSize: 60),),
            ),
            Align(
              alignment: Alignment.center,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height/3, 20, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                    child: Column(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width/1.5,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 233, 175),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Username",
                              contentPadding:
                              EdgeInsets.all(5),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 15,),
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width/1.5,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 198, 233, 175),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Password",
                              contentPadding:
                              EdgeInsets.all(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3, 0, 0, 0),
                          child: Text("Don't have account?", style: TextStyle(color: Color.fromARGB(255, 45, 80, 22),),),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/20,),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                          },
                          child: Text("Login"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                              textStyle: TextStyle(
                                  fontFamily: "Damion",
                                  fontSize: 20
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

