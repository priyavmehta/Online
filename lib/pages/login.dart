import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

// own imports
import 'package:priyav_mart/provider/user_provider.dart';
import '../loading.dart';
import 'home.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool hidePassPassword = true;

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {

    setState(() {
      loading = true;
    });

    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if(firebaseUser != null){
      isLogedin = true;
    }

    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[

                      SizedBox(height:40.0,),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: SvgPicture.asset(
                                'Images/login.svg',
                                width: 260.0,
                              )
                        ),
                      ),

                      Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              icon: Icon(Icons.alternate_email),
                              border: InputBorder.none
                            ),
                            validator: (value){
                              if (value.isEmpty) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            },
                          ),
                        )
                      ),
                    ),


                      Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            obscureText: hidePassPassword,
                            controller: _passwordTextController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                              border: InputBorder.none
                            ),
                            validator: (value){
                              if(value.isEmpty){
                                return "The password Field cannot be empty";
                              }else if (value.length < 6) {
                                return "The password must atleast be 6 characters long";
                              }
                              return null;
                            },
                          ), 
                        )
                      ),
                    ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black,
                          child: MaterialButton(
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                if(!await user.signIn(
                                  _emailTextController.text,
                                  _passwordTextController.text
                                  )){
                                    _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                }else{
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                }
                              }
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                          )
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Forgot password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Create an account",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              )
                            )
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("or sign in with", style: TextStyle(fontSize: 18,color: Colors.grey),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                  onPressed: () {},
                                  child: Image.asset("Images/google.jpg", width: 30,)
                              ),
                            ), 
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}