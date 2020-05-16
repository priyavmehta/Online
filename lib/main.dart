//imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//own imports
import './pages/login.dart';
import 'provider/user_provider.dart';
import 'package:priyav_mart/pages/home.dart';
import 'package:priyav_mart/pages/splash.dart';
import 'provider/app_provider.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepOrange
        ),
        home: ScreensController(),
      )
    )
  );
}

class ScreensController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



