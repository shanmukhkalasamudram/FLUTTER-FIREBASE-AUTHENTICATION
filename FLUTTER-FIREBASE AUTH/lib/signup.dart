import 'package:flutter/material.dart';
import 'home1.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  @override
  
  final _auth= FirebaseAuth.instance;
  final _firestore= Firestore.instance;
 
  
  String email;
  String password;
  
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
           padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
          child: Text(
            'Its not to late',
            style: TextStyle(
              fontSize: 75.0 , fontWeight: FontWeight.bold,
              color: Colors.blue
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Emailid',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    onChanged: (val){
                        
                          email = val;
                        
                      },
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                    onChanged: (val){
                        
                          password = val;
                        
                      },
                  ),
                  
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        
                        shadowColor: Colors.greenAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: ()
                          {

                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
                              .then((signedInUser){
                          _firestore.collection('users')
                            .add({'email' : email, 'pass' : password,})
                          .then((value){
                            if (signedInUser!= null){
                             Navigator.pushNamed(context, '/home1');
                            }
                          })
                          .catchError((e){
                          print(e);
                          }) ;
                     }
                     )
                    .catchError((e){
                      print(e);
                    });




                                
                          },

                          
                          child: Center(
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                  )),

                  //go back 
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0
                              ),
                          borderRadius: BorderRadius.circular(20.0),

                          color: Colors.transparent ) ,
                          
                          
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: 
                        
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                        
                        
                      ),

                      ),



                    ),

                    SizedBox(height: 50.0),
             Container(
                    
                   
                    child: Image(
                      image: AssetImage('assets/logo2.jpg', ))
                      
                    ,),



                
                ],
              )),
          
        ]));
  }
 






}



