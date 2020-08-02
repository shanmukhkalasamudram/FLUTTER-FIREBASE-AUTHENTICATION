import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home1.dart';
import 'signup.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  
  final _auth=FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

     
      resizeToAvoidBottomPadding: false,
      body: Column(children: <Widget>[
        
       
                      
                      
                      
        Container(
           padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
          child: Text(
            'Welcome User ',
            style: TextStyle(
              fontSize: 75.0 , fontWeight: FontWeight.bold,
              color: Colors.green
            ),
          ),
        ),

        Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'EmailId',
                          labelStyle: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                              )
                              ),
                      onChanged: (value){
                        setState(() {
                          email = value;
                        });
                      },

                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              
                              color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                              )
                              ),
                      obscureText: true,

                      onChanged: (value){
                        setState(() {
                          password = value;
                        });
                      }


                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container (
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.black,
                        color: Colors.black,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance
                              .signInWithEmailAndPassword(email: email, password: password)

                              .then((FirebaseUser ) {
                              //.then((AuthResult auth){

                                //Navigator.pushNamed(context, '/home1');
                                //Navigator.of(context).pushReplacementNamed('/homepage');
                                Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => new HomePage1())
                                );
                                }                             
                            
                                )
                                .catchError((e){
                                  print(e);
                                });

                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  
                            ),
                          ),
                        ),
                      ),
                      ),
                      ),


                    




                  ],
                  ),
        ),

        SizedBox(height: 15.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Not yet registered ?',
                  style: TextStyle(fontFamily: 'Montserrat'
                  ),
              ),
              SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                     ),
                )
              ],
            ),

             SizedBox(height: 50.0),
             Container(
                    
                   
                    child: Image(
                      image: AssetImage('assets/logo1.png', ))
                      
                    ,),



            ],
        )

        





    );
  }
}
