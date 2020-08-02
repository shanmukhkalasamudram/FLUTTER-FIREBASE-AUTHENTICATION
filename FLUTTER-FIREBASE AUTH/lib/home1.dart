import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'main.dart';
import 'loginpage.dart';


final Color backgroundColor = Colors.white;

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  bool liked= false;
    String bio;

    List<String> _comments = ["Welcome to the family","hi"];
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  

  


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    
    

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                (Row(
                children: <Widget>[
                Icon(Icons.history,color: Colors.black,size: 30.0,),
                SizedBox(width: 10),
                Text(
                  'Schedule meeting ',
                  style: TextStyle(color: Colors.black, fontSize: 22
                  ),
                ),
              ],)),
                SizedBox(height: 10),
                (Row(
                children: <Widget>[
                Icon(Icons.access_time,color: Colors.black,size: 30.0,),
                SizedBox(width: 10),
                Text(
                  'Reminders ',
                  style: TextStyle(color: Colors.black, fontSize: 22
                  ),
                ),
              ],)),
                SizedBox(height: 10),
                (Row(
                children: <Widget>[
                Icon(Icons.adjust,color: Colors.black,size: 30.0,),
                SizedBox(width: 10),
                Text(
                  'Meetings  ',
                  style: TextStyle(color: Colors.black, fontSize: 22
                  ),
                ),
              ],)),
                SizedBox(height: 10),
                (Row(
                children: <Widget>[
                Icon(Icons.comment,color: Colors.black,size: 30.0,),
                SizedBox(width: 10),
                Text(
                  'Messages',
                  style: TextStyle(color: Colors.black, fontSize: 22
                  ),
                ),
              ],)),
                
                SizedBox(height: 400),
                (Row(
                children: <Widget>[
                Icon(Icons.home,color: Colors.black,size: 30.0,),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                          FirebaseAuth.instance
                              .signOut().then((value){

                                Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => new LoginPage())
                                );
                                

                              }).catchError((e){
                                print(e);
                              });
                        },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22),
                     ),
                )
               
              ],)),


                
              ],
            ),
          ),
        ),
      ),
    );
  }



  

  Widget dashboard(context) {





    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.black),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("Welcome", style: TextStyle(fontSize: 24, color: Colors.black)),
                      Icon(Icons.settings, color: Colors.black),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[     
                       Text("Welcome", style: TextStyle(color: Colors.black, fontSize: 20),), 

                      

                     Container(
                    
                    child: Image(
                      image: AssetImage('assets/sample.jpg'),)
                    ,),

                    Container(
                    
                    child: Image(
                      image: AssetImage('assets/sample2.jpg'),)
                    ,),
                     
                     
                      

                           
                      ],
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