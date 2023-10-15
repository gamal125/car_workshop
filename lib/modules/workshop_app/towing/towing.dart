// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/Orders/MyOrdersScreen.dart';
import 'package:workshop_app/model/UserModel.dart';
import '../../../components/components.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../shared/local/cache_helper.dart';
import '../../profile/profile.dart';


class Towing_Screen extends StatefulWidget {
  @override
  State<Towing_Screen> createState() => _Towing_ScreenState();
}

class _Towing_ScreenState extends State<Towing_Screen> {

  String type=CacheHelper.getData(key: 'type');
  String address='';

  @override
  Widget build(BuildContext context) {
String longitude=  AppCubit.get(context).longitude;
String Latitude=  AppCubit.get(context).Latitude;
List <UserModel> model=[];
var  cubit=AppCubit.get(context);
Size screenSiz = MediaQuery.of(context).size;
model=cubit.AllTowing;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if(state is GetMyOrdersSuccessState){
          navigateTo(context, MyOrder_Screen(type:type));
        }
        if(state is OrderingSuccessState){
          showToast(text: 'order received', state: ToastStates.success);
        }
        if(state is GetLocationSuccessState){
          setState(()  {
            longitude=  AppCubit.get(context).longitude;
            Latitude=  AppCubit.get(context).Latitude;

          });
          address=await getAddressFromCoordinates(double.parse(Latitude),double.parse(longitude));
          if(type!='towing'){
          AppCubit.get(context).getAllTowing();}else{
          AppCubit.get(context).gettowingitself();}
        }
      },
      builder: (context, state) {

        return type=='towing'?
        Scaffold(

          body:  SafeArea(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        cubit.gettowingmyorders();

                      }, icon:const Icon( Icons.menu_open,color: Colors.blue,)),

                      IconButton(onPressed: (){      cubit.ud!=''?cubit.getUser(cubit.ud): navigateTo(context, ProfileScreen());
                      navigateTo(context, ProfileScreen());
                      }, icon:const Icon( Icons.person,color: Colors.blue,)),
                    ],),
                ),
                Column(

                  children: [
                    ConditionalBuilder(
                      condition: state is GetTowingItSelfSuccessState,
                      builder:(context)=>AppCubit.get(context).TowingUser!=null? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 150,width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppCubit.get(context).TowingUser!.image!=''?
                                Container(height: 120,width: 120,
                                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(AppCubit.get(context).TowingUser!.image!),fit: BoxFit.cover),shape: BoxShape.circle),
                                )
                                    :  Container(height: 120,width: 120,
                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/1.jpg'),fit: BoxFit.scaleDown),shape: BoxShape.circle),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(AppCubit.get(context).TowingUser!.name!.toUpperCase() ,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 25,fontWeight: FontWeight.bold),maxLines: 1,),
                                          ],
                                        ),
                                        Text(address,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 18),maxLines: 3,)
                                      ],

                                    ),
                                  ),
                                ),


                              ],),
                          ),
                        ),
                      ):const Center(child: Text('press (+) to add your self to Towing list'),), fallback: (BuildContext context) => Center(child: CircularProgressIndicator(),),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
                if(longitude!=''){
                  AppCubit.get(context).addtowing(Latitude: Latitude, Longitude: longitude);
                }else{
                  AppCubit.get(context).getLocation();
                }
          },child: const Icon(Icons.add),),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(50) ,topRight: Radius.circular(50)
              )
              , boxShadow: [
              BoxShadow(
                color:   Colors.blue.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            ),
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(color: Colors.blue,),
              selectedItemColor: Colors.blue,

              items:cubit.BottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },


            ),
          ),
        ): Scaffold(
          body:  SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            cubit.getmyorders();

                          }, icon:const Icon( Icons.menu_open,color: Colors.blue,)),
                          IconButton(onPressed: (){      cubit.ud!=''?cubit.getUser(cubit.ud): navigateTo(context, ProfileScreen());
                          navigateTo(context, ProfileScreen());
                          }, icon:const Icon( Icons.person,color: Colors.blue,)),
                        ],),
                    ),
                  ],
                ),
                Container(
                // Set a fixed height for the scrollable part
                child: ConditionalBuilder(
                  condition: state is GetAllTowingSuccessState||state is OrderingSuccessState,
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => model.isNotEmpty? review(model[index], context):Text('No Reviews Yet'),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: model.length,
                  ),
                  fallback: (context) =>  Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Colors.blue.withOpacity(.8),
                        size: screenSiz.width / 12,
                      ))
                  ),
              ),
              ]
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(50) ,topRight: Radius.circular(50)
              )
              , boxShadow: [
              BoxShadow(
                color:   Colors.blue.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            ),
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(color: Colors.blue,),
              selectedItemColor: Colors.blue,

              items:cubit.BottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },


            ),
          ),
        );
      },
    );
  }
  Widget review(UserModel model,  context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 100,width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          model.image!=''?
          Container(height: 50,width: 50,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(model.image!),fit: BoxFit.cover),shape: BoxShape.circle),
          )
              :  Container(height: 50,width: 50,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/1.jpg'),fit: BoxFit.scaleDown),shape: BoxShape.circle),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text(model.name!,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(address=(Geolocator.distanceBetween(
                        double.parse(AppCubit.get(context).Latitude),
                        double.parse(AppCubit.get(context).longitude),
                        double.parse(model.Latitude),
                        double.parse(model.Longitude),
                      )/1000).toStringAsFixed(1),style: TextStyle(overflow: TextOverflow.ellipsis,color:double.parse(address)<=2?Colors.green:Colors.red ),maxLines: 2,),
                      Text(' Km')
                    ],
                  )],
              ),
            ),
          ),


          Row(
mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(onPressed: (){
                AppCubit.get(context).userorderingtowing(
                    name: model.name!,
                    image: model.image!,
                    uid: model.uId!,
                    phone: model.phone!,
                    Latitude: model.Latitude,
                    longitude:model.Longitude);
              }, child: Text('order',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 18),)),

              SvgPicture.asset('assets/icon/shipping.svg',width:24,height: 36,color: Colors.black,),

          ],)

        ],),
    ),
  );
  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
         address = ' ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        return address;
      } else {
        return 'No address found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }



}
