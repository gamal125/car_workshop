import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/cubit/states.dart';
import 'package:workshop_app/modules/profile/updateprofile.dart';

import '../../components/components.dart';
import '../../layout/todo_layout.dart';
import '../../login/login_screen.dart';
import '../../main.dart';
import '../../shared/local/cache_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var selectionMode;

  var isChecked=false;

  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is LogoutSuccessState){

          CacheHelper.saveData(key: 'uId', value: '');
          CacheHelper.saveData(key: 'type', value: '');
          AppCubit.get(context).ud='';
          navigateAndFinish(context, MyHomePage(title: '',));
        }

      },
      builder: (context, state) {
        return CacheHelper.getData(key: 'uId')==null||CacheHelper.getData(key: 'uId')==''||AppCubit.get(context).userdata==null?


        Scaffold(
          appBar: AppBar(elevation: 0,systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),),

          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [

                        Color.fromRGBO(34, 149, 255, 0.65), // First color (top half)
                        Colors.white, // Second color (bottom half)
                      ],
                      stops: [0.2, 0.2], // Set the stops to create a sharp transition between the colors
                    ),
                  ),
                  child:  Column(

                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 72.0),
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children:[

                              CircleAvatar(backgroundImage: AssetImage('assets/icon/1.jpg'),radius: 60,),


                            ]

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text('new user',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text('******gmail.com',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 14),
                        child: Text('************',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),

                      myDivider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0,right: 20,left: 20,bottom: 10),
                        child: Container(
                            height: 43,
                            width: double.infinity,
                            decoration: BoxDecoration(   borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                ConditionalBuilder(
                                  condition: state is! LogoutLoadingState,
                                  builder: (context)=>TextButton(onPressed: () { navigateTo(context, LoginScreen()); },
                                    child:Text('تسجيل دخول',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.black),),
                                  ),
                                  fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                                ) ,
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(   width: 40,height: 40,

                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.withOpacity(0.2)),

                                    child: Icon(Icons.logout_rounded,color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),


        ):
        Scaffold(
        appBar: AppBar(elevation: 0,systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [

                      Colors.blue, // First color (top half)
                        Colors.white, // Second color (bottom half)
                      ],
                      stops: [0.2, 0.2], // Set the stops to create a sharp transition between the colors
                    ),
                  ),
                  child:  Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 72.0),
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children:[

                              AppCubit.get(context).userdata!.image==''||AppCubit.get(context).userdata!.image==null?  CircleAvatar(backgroundImage: AssetImage('assets/icon/1.jpg'),radius: 60,):
                              CircleAvatar(backgroundImage: NetworkImage('${AppCubit.get(context).userdata!.image!}'),radius: 60,),
                              Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),                              color: Colors.white,
                                  ),
                                  child: IconButton( onPressed: (){navigateTo(context, UpdateProfileScreen()); }, icon: Icon(Icons.edit,color: Colors.blue,size: 18,))),

                            ]

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text('${AppCubit.get(context).userdata!.name!}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text('${AppCubit.get(context).userdata!.email!}',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 14),
                        child: Text('${AppCubit.get(context).userdata!.phone!}',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 12.0,right: 20,left: 20,bottom: 10),
                        child: Container(
                            height: 43,
                            width: double.infinity,
                            decoration: BoxDecoration(   borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                ConditionalBuilder(
                                  condition: true,
                                  //state is! LogOutLoadingState,
                                  builder: (context)=>TextButton(onPressed: () {
                                    AppCubit.get(context).signout();
                                    },
                                    child:Text('تسجيل الخروج',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.black),),
                                  ),
                                  fallback: (context)=>  Center(
                                      child: LoadingAnimationWidget.inkDrop(
                                        color: Colors.blue.withOpacity(.8),
                                        size: screenSiz.width / 12,
                                      ))
                                ) ,
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(   width: 40,height: 40,                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.withOpacity(0.2)),

                                    child: Icon(Icons.logout_rounded,color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                      ),

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //
                      //     Padding(
                      //         padding: const EdgeInsets.only(top: 40.0,bottom: 15),
                      //
                      //         child: ConditionalBuilder(
                      //           condition: state is! LogOutLoadingState,
                      //           builder: (context)=>TextButton(onPressed: () { NewsCubit.get(context).signout(); },
                      //             child:Text('تسجيل الخروج',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Color.fromRGBO(34, 149, 255, 0.65)),),
                      //           ),
                      //           fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                      //         ) ),
                      //     Container(
                      //       height: 25,
                      //       width: 170,
                      //       decoration: BoxDecoration(
                      //
                      //         image:DecorationImage(image: AssetImage('assets/images/logo.png'),fit: BoxFit.scaleDown),),),
                      //     Text('جميع الحقوق محفوظة',style: TextStyle(color: Colors.grey),)
                      //   ],
                      // )

                    ],
                  ),
                ),
              ),
            ],
          ),

        );


      },
    );
  }



}
