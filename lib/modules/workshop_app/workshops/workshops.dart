// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/components/components.dart';
import 'package:workshop_app/details/details_shop_screen.dart';
import 'package:workshop_app/model/WorkshopModel.dart';
import 'package:workshop_app/modules/search/searchScreen2.dart';
import 'package:workshop_app/modules/workshop_app/addshop/addshop.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../shared/local/cache_helper.dart';
import '../../profile/profile.dart';


class Work_Shops_Screen extends StatefulWidget {
  int tappedButtonIndex=0;

  List<WorkshopModel> workshops=[];
  @override
  State<Work_Shops_Screen> createState() => _Work_Shops_ScreenState();
}

class _Work_Shops_ScreenState extends State<Work_Shops_Screen> {


  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    String type=CacheHelper.getData(key: 'type');
    var cubit=AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is GetworkshopsSuccessStates)
        {
          widget.workshops.clear();
          widget.tappedButtonIndex=0;
          cubit.workshops.forEach((element) {

            widget.workshops.add(element);
          });
        }
      },
      builder: (context, state) {
        if (type!='shopowner') {
          return
            Scaffold(

            body:  SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){navigateTo(context, SearchScreen2());}, icon:const Icon( Icons.search,color: Colors.blue,)),
                        IconButton(onPressed: (){      cubit.ud!=''?cubit.getUser(cubit.ud): navigateTo(context, ProfileScreen());
                        navigateTo(context, ProfileScreen());
                        }, icon:const Icon( Icons.person,color: Colors.blue,)),
                      ],),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.workshops.clear();
                                widget.tappedButtonIndex=0;
                                cubit.workshops.forEach((element) {

                                  widget.workshops.add(element);
                                });

                              });
                            },
                            child: Text("All",style: TextStyle(color: widget.tappedButtonIndex==0? Colors.indigo:Colors.grey),),
                          ),

                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.workshops.clear();
                                widget.tappedButtonIndex=1;
                                cubit.workshops.forEach((element) {
                                  if(element.type=='Paint and bodyworks')
                                  {widget.workshops.add(element);}
                                });

                              });
                            },
                            child: Text("Paint and bodyworks",style: TextStyle(color: widget.tappedButtonIndex==1? Colors.indigo:Colors.grey),),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.workshops.clear();
                                widget.tappedButtonIndex=2;
                                cubit.workshops.forEach((element) {
                                  if(element.type=='Tire jobs')
                                  {widget.workshops.add(element);}
                                });
                              });
                            },
                            child: Text("Tire jobs",style: TextStyle(color: widget.tappedButtonIndex==2? Colors.indigo:Colors.grey),),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.workshops.clear();

                              setState(() {
                                widget.tappedButtonIndex=3;
                                cubit.workshops.forEach((element) {
                                  if(element.type=='Performance jobs')
                                  {widget.workshops.add(element);}
                                });
                              });

                            },
                            child: Text("Performance jobs",style: TextStyle(color: widget.tappedButtonIndex==3? Colors.indigo:Colors.grey),),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.workshops.clear();

                              setState(() {
                                widget.tappedButtonIndex=4;
                                cubit.workshops.forEach((element) {
                                  if(element.type=='Quick service')
                                  {widget.workshops.add(element);}
                                });
                              });
                            },
                            child: Text("Quick service",style: TextStyle(color: widget.tappedButtonIndex==4? Colors.indigo:Colors.grey),),
                          ),



                        ],
                      )
                  ),

                  ConditionalBuilder(
                      condition: state is! AppChangeBottomNavBarState,
                      builder: (context){return

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                widget.workshops.isNotEmpty?  GridView.count(

                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1 / 1.6,
                                  children: List.generate(

                                  widget.workshops.length
                                    ,(index) =>
                                      gridworkshops(  widget.workshops[index], context,type),
                                  ).animate().fade(begin: 0.1,end: 0.9),
                                ):Center(child: Text('لا توجد منتجات')),

                              ],
                            ),
                          ),
                        );
                        },
                      fallback: (context){return Center(child: CircularProgressIndicator());})

                ],
              ),
            ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)
              )
              , boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            ),
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(color:Colors.blue,),
              selectedItemColor: Colors.blue,

              items: cubit.BottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },


            ),
          ),
        );
        } else {
          return Scaffold(
          body:  SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){navigateTo(context, SearchScreen2());}, icon:const Icon( Icons.search,color: Colors.blue,)),
                      IconButton(onPressed: (){      cubit.ud!=''?cubit.getUser(cubit.ud): navigateTo(context, ProfileScreen());
                      navigateTo(context, ProfileScreen());
                      }, icon:const Icon( Icons.person,color: Colors.blue,)),
                    ],),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.workshops.clear();
                              widget.tappedButtonIndex=0;
                              cubit.workshops.forEach((element) {

                                widget.workshops.add(element);
                              });

                            });
                          },
                          child: Text("All",style: TextStyle(color: widget.tappedButtonIndex==0? Colors.indigo:Colors.grey),),
                        ),

                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.workshops.clear();
                              widget.tappedButtonIndex=1;
                              cubit.workshops.forEach((element) {
                                if(element.type=='Paint and bodyworks')
                                {widget.workshops.add(element);}
                              });

                            });
                          },
                          child: Text("Paint and bodyworks",style: TextStyle(color: widget.tappedButtonIndex==1? Colors.indigo:Colors.grey),),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.workshops.clear();
                              widget.tappedButtonIndex=2;
                              cubit.workshops.forEach((element) {
                                if(element.type=='Tire jobs')
                                {widget.workshops.add(element);}
                              });
                            });
                          },
                          child: Text("Tire jobs",style: TextStyle(color: widget.tappedButtonIndex==2? Colors.indigo:Colors.grey),),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.workshops.clear();

                            setState(() {
                              widget.tappedButtonIndex=3;
                              cubit.workshops.forEach((element) {
                                if(element.type=='Performance jobs')
                                {widget.workshops.add(element);}
                              });
                            });

                          },
                          child: Text("Performance jobs",style: TextStyle(color: widget.tappedButtonIndex==3? Colors.indigo:Colors.grey),),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.workshops.clear();

                            setState(() {
                              widget.tappedButtonIndex=4;
                              cubit.workshops.forEach((element) {
                                if(element.type=='Quick service')
                                {widget.workshops.add(element);}
                              });
                            });
                          },
                          child: Text("Quick service",style: TextStyle(color: widget.tappedButtonIndex==4? Colors.indigo:Colors.grey),),
                        ),



                      ],
                    )
                ),
                ConditionalBuilder(
                    condition: state is! AppChangeBottomNavBarState&&state is!DeleteWorkSuccessState,
                    builder: (context){return

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                          widget.workshops.isNotEmpty? GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1 / 1.6,
                                children: List.generate(

                                  widget.workshops.length
                                  ,(index) =>
                                    gridworkshops(widget.workshops[index], context,type),
                                ).animate().fade(begin: 0.1,end: 0.9),
                              ):Center(child: Text('لا توجد منتجات')),

                            ],
                          ),
                        ),
                      );
                    },
                    fallback: (context){return   Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: Colors.blue.withOpacity(.8),
                          size: screenSiz.width / 12,
                        ));})
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () { navigateTo(context, AddShop()); },child: Icon(Icons.add),),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)
              )
              , boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            ),
            child: BottomNavigationBar(
              selectedIconTheme: const IconThemeData(color:Colors.blue,),
              selectedItemColor: Colors.blue,

              items: cubit.BottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },


            ),
          ),
        );
        }
      });
  }

  Widget gridworkshops(WorkshopModel model, context,String type) =>
     type=='admin'?
      InkWell(
    onTap: () {
      AppCubit.get(context).getShopReviews(model.uId!, model.name!);

      navigateTo(context,
          DetailsShop(
            image: model.image!,
            name: model.name!,
            phone: model.phone!,
            description: model.description!,
            location: model.location!,
            rate: model.rate!, uidpublisher: model.uId!, image2:model.image2! , image3: model.image3!,)
      );
    },
    child: Container(
      decoration: BoxDecoration(      borderRadius: BorderRadius.circular(20),    boxShadow: [
        BoxShadow(
          color:   Colors.grey.withOpacity(0.6),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 3),
        ),
      ],),
      child: Stack(
        children: [
          Card(


            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.none,
            elevation: 0,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage( image:
                    NetworkImage(model.image!,),fit: BoxFit.cover

                    ),


                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              model.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Dubai',
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            '${model.location!}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Dubai',
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),



                        ],
                      ),
                      Text(
                        model.description!,
                        style: const TextStyle(
                          fontSize: 16,

                          fontFamily: 'Dubai',
                          color: Colors.black,
                        ),overflow: TextOverflow.ellipsis,maxLines: 2,
                      ),




// defaultMaterialButton3(
//
//   function: () {
//
//     NewsCubit.get(context).getR_User(model.uId!);
//   },
//   text: 'تواصل مع البائع',
//   radius: 20, color: Colors.blue,
// ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: IconButton(
                  alignment: AlignmentDirectional.bottomCenter,
                  onPressed: (){AppCubit.get(context).deleteWorkShop(name: model.name!, id: model.uId!,);}, icon:Icon( Icons.delete,color: Colors.red,)),
            ),
          )
        ],
      ),
    ),
  ): InkWell(
        onTap: () {
          AppCubit.get(context).getShopReviews(model.uId!, model.name!);

          navigateTo(context,
              DetailsShop(
                image: model.image!,
                name: model.name!,
                phone: model.phone!,
                description: model.description!,
                location: model.location!,
                rate: model.rate!, uidpublisher: model.uId!, image2: model.image2!, image3: model.image3!,)
          );
        },
        child: Container(
          decoration: BoxDecoration(      borderRadius: BorderRadius.circular(20),    boxShadow: [
            BoxShadow(
              color:   Colors.grey.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],),
          child: Card(


            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.none,
            elevation: 0,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage( image:
                    NetworkImage(model.image!,),fit: BoxFit.cover

                    ),


                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              model.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Dubai',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Text(
                            '${model.location!}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Dubai',
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),



                        ],
                      ),
                      Text(
                        model.description!,
                        style: const TextStyle(
                          fontSize: 16,

                          fontFamily: 'Dubai',
                          color: Colors.black,
                        ),overflow: TextOverflow.ellipsis,maxLines: 2,
                      ),




// defaultMaterialButton3(
//
//   function: () {
//
//     NewsCubit.get(context).getR_User(model.uId!);
//   },
//   text: 'تواصل مع البائع',
//   radius: 20, color: Colors.blue,
// ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
