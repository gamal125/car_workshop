// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workshop_app/Orders/ArchievOrders.dart';
import 'package:workshop_app/layout/todo_layout.dart';
import 'package:workshop_app/model/OrderModel.dart';
import '../../../components/components.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';


class MyOrder_Screen extends StatefulWidget {
  @override
  State<MyOrder_Screen> createState() => _MyOrder_ScreenState();
  MyOrder_Screen({required this.type});
String type;
}

class _MyOrder_ScreenState extends State<MyOrder_Screen> {

  String address='';


  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    String longitude=  AppCubit.get(context).longitude;
    String Latitude=  AppCubit.get(context).Latitude;
    List <OrderModel> model=[];
    var  cubit=AppCubit.get(context);

    model=cubit.MyOrders;
    print(model.length);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is GetMyOrdersSuccessState){
          setState(() {
            model=cubit.MyOrders;
          });
        }

      },
      builder: (context, state) {

        return Scaffold(
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
                              AppCubit.get(context).changeIndex(2);
                           navigateAndFinish(context, Home_Layout());
                            }, icon:const Icon( Icons.arrow_back_ios,color: Colors.blue,)),
                            IconButton(onPressed: (){

                              navigateTo(context, ArchieveOrder_Screen(type: widget.type));
                            }, icon:const Icon( Icons.archive,color: Colors.blue,)),

                          ],),
                      ),
                    ],
                  ),
                 widget.type=='towing'? Container(
                    // Set a fixed height for the scrollable part
                    child: ConditionalBuilder(
                        condition: state is GetMyOrdersSuccessState,
                        builder: (context) => ConditionalBuilder(
                          condition: model.isNotEmpty,
                          builder:(context)=> ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>  towingorder(model[index], context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: model.length,
                          ), fallback: ( context)=> const Center(child:  Text('No  order yet')),
                        ),
                        fallback: (context) =>  Center(
                            child: LoadingAnimationWidget.inkDrop(
                              color: Colors.blue.withOpacity(.8),
                              size: screenSiz.width / 12,
                            ))
                    ),
                  ): Container(
                    // Set a fixed height for the scrollable part
                    child: ConditionalBuilder(
                        condition: state is GetMyOrdersSuccessState,
                        builder: (context) => ConditionalBuilder(
                          condition: model.isNotEmpty,
                          builder:(context)=> ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>  order(model[index], context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: model.length,
                          ), fallback: ( context)=> const Center(child:  Text('No  order yet')),
                        ),
                        fallback: (context) =>Center(child: CircularProgressIndicator(),)
                    ),
                  ),
                ]
            ),
          ),

        );
      },
    );
  }
  Widget order(OrderModel model,  context)=>Padding(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(model.name!),
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
              Text(model.state!),
              TextButton(onPressed: (){},
                  child: const Text('delete',style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontSize: 18),)),


            ],)

        ],),
    ),
  );
  Widget towingorder(OrderModel model,  context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 100,width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(model.name!,style: TextStyle(fontSize: 18),),
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
                          Text(' Km',style: TextStyle(color: Colors.grey),)
                        ],
                      )],
                  ),
                ),
              ),



            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(onPressed: ()async{
                AppCubit.get(context).acceptinguserorderingtowing(name: model.name!, image: model.image!, uid: model.uId!, phone: model.phone!, Latitude: model.Latitude, longitude: model.Longitude);
                final url = 'https://www.google.com/maps/search/?api=1&query=${model.Latitude},${model.Longitude}';


                  await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);

              },child: Text('Accept'),color: Colors.green,),
              MaterialButton(onPressed: (){AppCubit.get(context).declineorders(id: model.uId!);},child: Text('decline'),color: Colors.red,),



            ],)
        ],
      ),
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
