import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:workshop_app/components/components.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/layout/todo_layout.dart';
import 'package:workshop_app/login/login_screen.dart';
import 'package:workshop_app/register/cubit/cubit.dart';
import 'package:workshop_app/shared/local/cache_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Applocalizition.dart';
import 'bloc_observer.dart';
import 'login/cubit/maincubit.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}
void main() async{
  Widget widget;
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  await Firebase.initializeApp();
  var uId=CacheHelper.getData(key: 'uId');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  if(uId != null&&uId!=''){
    widget=SplashScreenView(
      duration: 3000,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      navigateRoute: Home_Layout(),
      text: ' Welcome dear',
      textType: TextType.ColorizeAnimationText,
      textStyle:  TextStyle(     fontSize: 40,
        fontWeight: FontWeight.w700,) ,
    );
  }
  else{

    widget=SplashScreenView(
      duration: 3000,
      pageRouteTransition: PageRouteTransition.SlideTransition,
      navigateRoute: const MyHomePage(title: ''),
      text: ' Welcome',
      textType: TextType.ColorizeAnimationText,
      textStyle:  TextStyle(     fontSize: 40,
        fontWeight: FontWeight.w700,) ,


    );



  }
  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
    MyApp({super.key,   required this.startWidget});
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [


        BlocProvider(
            create: (context) => LoginCubit()

        ),
        BlocProvider(
            create: (context) => AppCubit()..getusers()..gettokens()..getUser(CacheHelper.getData(key: 'uId'))..setToken(CacheHelper.getData(key: 'uId'))


        ),
        BlocProvider(
            create: (context) => RegisterCubit()

        ),

      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('ar', 'SA'), // Arabic (Saudi Arabia)
        ],
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
 
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/back.jpg'),fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              defaultMaterialButton(function:(){
                CacheHelper.saveData(key: 'type', value: "customer");
                navigateTo(context, LoginScreen());
              } , text: 'customer'),
              const SizedBox(height: 30,),
              defaultMaterialButton(function:(){
                CacheHelper.saveData(key: 'type', value: "towing");
                navigateTo(context, LoginScreen());
              } , text: 'towing'),
              const SizedBox(height: 30,),
              defaultMaterialButton(function:(){
                CacheHelper.saveData(key: 'type', value: "admin");
                navigateTo(context, LoginScreen());
              } , text: 'admin'),
              const SizedBox(height: 30,),
              defaultMaterialButton(function:(){
                CacheHelper.saveData(key: 'type', value: "shopowner");
                navigateTo(context, LoginScreen());
              } , text: 'shop owner'),      const SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }

}
