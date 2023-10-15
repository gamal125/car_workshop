import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workshop_app/AddReview/AddReviews.dart';
import 'package:workshop_app/AllUserReviews/AllUserReviews.dart';
import 'package:workshop_app/components/components.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/login/login_screen.dart';
import 'package:workshop_app/shared/local/cache_helper.dart';

import '../cubit/states.dart';
import '../model/ReviewModel.dart';
import 'details_review_screen.dart';

class detailsServices extends StatefulWidget {
   detailsServices({Key? key,
    required this.image,
     required this.image2,
     required this.image3,
    required this.uidpublisher,
    required this.name,
    required this.price,
    required this.phone,
    required this.description,
    required this.location,
    required this.rate,


  }) : super(key: key);
  final image;
  final image2;
  final image3;
  final name;
  final uidpublisher;
  final price;
  final phone;
  final description;
  final location;
  final rate;
   double sum=0;
  @override
  State<detailsServices> createState() => _detailsServicesState();
}

class _detailsServicesState extends State<detailsServices> {

  @override
  Widget build(BuildContext context) {
    List <ReviewModel> model=[];
    List<String> mod=[widget.image,widget.image2,widget.image3];
    var c=AppCubit.get(context);
      model=c.serviceReviews;



    return  BlocConsumer<AppCubit, AppStates>(
      listener:(context, state){
        if(state is GetAllServiceReviewSuccessState){
          if(AppCubit.get(context).AllReviews.isNotEmpty){
                    navigateTo(context, AllUserReviewsScreen());
          }
        }


        if(model.isNotEmpty){
          widget.sum=0;

          model.forEach((element) {
            setState(() {
             widget.sum+=element.rating!;

            });

          });
          setState(() {
            widget.sum=widget.sum/model.length;
            widget.sum=widget.sum;

          });
          print(widget.sum);
        }
      } ,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading:IconButton(onPressed: (){Navigator.pop(context);},      icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.blue,),)
            ,
          ),
          body: ListView(
            children:[
              SizedBox(height: 10,),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: double.infinity,
                  child: CarouselSlider(
                    items: mod
                        .map(
                          (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              image: NetworkImage(e),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    ),
                    Text(
                      widget.location!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, style: const TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20,),
                        const Text(
                          'Service',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          widget.sum.toStringAsFixed(2) ,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.star, color: Colors.indigo,),

                      ],
                    ),
                    SizedBox(height: 5,),

                    const Text(
                      "Description",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 5,),

                    Text(
                      widget.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis, style: const TextStyle(
                      fontSize: 14,

                      color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 5,),

                    const Text(
                      'Reviews',

                      overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    ),





                  ],),
              ),

            ],),

          Container(
              height: 240.0, // Set a fixed height for the scrollable part
              child: ConditionalBuilder(
                  condition: model.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => review(model[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: model.length,
                  ),
                  fallback: (context) =>Text('No Reviews Yet')
          ),
          ),
              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CacheHelper.getData(key: 'uId') != null &&
                      CacheHelper.getData(key: 'uId') != '' ?
                  defaultMaterialButton(function: () {
                    c.getUser(CacheHelper.getData(key: 'uId'));
                    navigateTo(context, AddReview(
                      uidPublisher: widget.uidpublisher, serviceName: widget.name,));
                  }, text: 'Add Review') :
                  defaultMaterialButton(function: () {
                    navigateTo(context, LoginScreen());
                  }, text: 'Add Review'),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.cyan.withOpacity(0.5)),
                    child: IconButton(onPressed: () {
                      sendToWhatsApp(phone: widget.phone.toString());
                    },
                      icon: SvgPicture.asset(
                        'assets/icon/whatsapp96.svg',),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.cyan.withOpacity(0.5)),

                    child: IconButton(onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(widget.phone!);
                    },
                        icon: Icon(Icons.phone, color: Colors.blue,)
                    ),
                  ),
                ],),
            ]
          ),
        );

      }
      );
  }

  Widget review(ReviewModel model,  context)=>InkWell(
    onTap: (){
      AppCubit.get(context).getallusersreview(id: AppCubit.get(context).ud);
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.blue.withOpacity(0.1),
        height: 70,width: double.infinity,
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(model.name!),
                      TextButton(onPressed: (){
                        navigateTo(context, DetailsReview(
                          image: model.image!,
                          image2: model.image2!,
                          image3: model.image3!,
                          name: model.name!,
                          Servicename: model.Servicename!,
                          image1: model.image1!,
                          uIdpublisher: model.uIdpublisher!,
                          uId: model.uId!,
                          rating: model.rating!,
                          comment: model.comment!,
                        ));
                      }, child: Text('عرض الصور')),
                    ],
                  ),
                  Text(model.comment!,style: TextStyle(overflow: TextOverflow.ellipsis,),maxLines: 2,)],
              ),
            ),
          ),
          Row(
            children: [
              Text(model.rating!.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              Icon(Icons.star,color: Colors.indigo,)
            ],
          ),

       ],),
      ),
    ),
  );

  void sendToWhatsApp({required String phone,})async{
    var mes='hello';
    var url='https://api.whatsapp.com/send?phone=2$phone&text=$mes';
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  }
}
