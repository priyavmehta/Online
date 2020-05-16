import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// own imports
import 'package:priyav_mart/loading.dart';
import 'package:priyav_mart/database/auth.dart';
import 'package:priyav_mart/database/users.dart';
import 'package:priyav_mart/pages/home.dart';
import 'package:priyav_mart/pages/login.dart';
import 'package:priyav_mart/commons/common.dart';
import 'package:priyav_mart/provider/user_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _key = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = new UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  String gender = "male";
  String groupValue = "male";
  bool loading =false;
  bool hidePassPassword = true;
  bool hidePassConfirmPassword = true;

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius:
                    20.0, // has the effect of softening the shadow
                  )
                ],
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40,),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              'Images/signUp.svg',
                              width: 200.0,
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
                              child: ListTile(
                                title: TextFormField(
                                  controller: _nameTextController,
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The name Field cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              )
                            )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "male",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Radio(
                                      value: "male",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e),
                                    )
                                  )
                                ),

                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "female",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Radio(
                                      value: "female",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e),
                                    )
                                  )
                                ),
                                
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                    border: InputBorder.none
                                  ),
                                  validator: (value) {
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
                              child: ListTile(
                                title: TextFormField(
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
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: (){
                                    setState(() {
                                      hidePassPassword = false;
                                    });
                                  },
                                ),
                              )
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
                              child: ListTile(
                                title: TextFormField(
                                  obscureText: hidePassConfirmPassword,
                                  controller: _confirmPasswordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none
                                  ),
                                  validator: (value){
                                    if(value.isEmpty){
                                      return "The password Field cannot be empty";
                                    }else if (value.length < 6) {
                                      return "The password must atleast be 6 characters long";
                                    }else if(_passwordTextController.text != value){
                                      return "The passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: (){
                                    setState(() {
                                      hidePassConfirmPassword = false;
                                    });
                                  },
                                ),
                              )
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
                                  if(!await user.signUp(
                                    _nameTextController.text,
                                    _emailTextController.text,
                                    _passwordTextController.text,
                                    gender
                                    )){
                                      _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                  }else{
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                  }
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Sign Up",
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

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                            },
                            child: Text(
                              "I already have an account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16 
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Or sign up with", style: TextStyle(fontSize: 18,color: Colors.grey),),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                child: MaterialButton(
                                  onPressed: () async{
                                    FirebaseUser user = await auth.googleSignIn();
                                    if(user != null){
                                      _userServices.createUser(
                                        name: user.displayName,
                                        email: user.email,
                                        gender: gender,
                                        userId: user.uid.toString(),
                                        password: "Google Password"
                                      );
                                      changeScreenReplacement(context, HomePage());
                                    }
                                  },
                                  child: Image.asset("Images/google.jpg", width: 30,)
                                )
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  valueChanged(e){
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      }else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async{
    FormState formState = _formKey.currentState;
    if(formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if(user == null) {
        firebaseAuth.createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text)
        .then((user) {
          print(user.user.uid);
          _userServices.createUser(
            name: _nameTextController.text,
            email: _emailTextController.text,
            gender: gender,
            userId: user.user.uid.toString(),
            password: _passwordTextController.text
          );
        }).catchError((e)=>{
            print(e.toString())
          });

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        print("hello");
      }
    }
  }
}