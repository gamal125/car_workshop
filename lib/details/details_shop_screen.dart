import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AddReview/AddShopReviews.dart';

import '../AllUserReviews/AllUserShopReviews.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../Applocalizition.dart';
import '../components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../login/login_screen.dart';
import '../model/ReviewModel.dart';
import '../shared/local/cache_helper.dart';
import 'details_review_screen.dart';

class DetailsShop extends StatefulWidget {
  final String image;
  final String image2;
  final String image3;
  final String name;
  final String phone;
  final String uidpublisher;
  final String description;
  final String location;
  final String rate;
  double sum=0;

   DetailsShop({Key? key,
    required this.image,
     required this.image2,
     required this.image3,
    required this.name,
    required this.uidpublisher,
    required this.phone,
    required this.description,
    required this.location,
    required this.rate,


  }) : super(key: key);

  @override
  State<DetailsShop> createState() => _DetailsShopState();
}

class _DetailsShopState extends State<DetailsShop> {
  @override
  Widget build(BuildContext context) {
    List <ReviewModel> model=[];
List<String> mod=[widget.image,widget.image2,widget.image3];
    var c=AppCubit.get(context);
    model=c.shopReviews;
    return BlocConsumer<AppCubit, AppStates>(
      listener:(context, state){
        if(state is GetAllShopReviewSuccessState){
          if(AppCubit.get(context).AllshopReviews.isNotEmpty){
            navigateTo(context, AllUserShopReviewsScreen());
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
      builder:(context, state){ return
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading:IconButton(onPressed: (){Navigator.pop(context);},      icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.blue,),)
            ,
          ),
          body: ListView(
            children:[
              SizedBox(height: 10,),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,children: [
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
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,     style: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  ),
                    Text(
                      widget.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,     style: const TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    ),
                    const SizedBox(height: 5,),

                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20,),
                      const Text(
                        'Workshop',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Text(
                        widget.sum.toStringAsFixed(2) ,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Icon(Icons.star,color: Colors.indigo,),

                    ],
                  ),
                    const SizedBox(height: 10,),

                    const Text(
                      "Description",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,     style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 5,),

                    Text(
                      widget.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,     style: const TextStyle(
                      fontSize: 14,

                      color: Colors.black,
                    ),
                    ),
                    const SizedBox(height: 10,),

                     Text(
                      AppLocalizations.of(context)!.translate('Reviews'),

                      overflow: TextOverflow.ellipsis,     style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CacheHelper.getData(key: 'uId') != null &&
                            CacheHelper.getData(key: 'uId') != '' ?
                        defaultMaterialButton(function: () {
                          c.getUser(CacheHelper.getData(key: 'uId'));
                          navigateTo(context, AddShopReview(
                            uidPublisher: widget.uidpublisher, shopName: widget.name,));
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
                            await FlutterPhoneDirectCaller.callNumber(widget.phone);
                          },
                              icon: Icon(Icons.phone, color: Colors.blue,)
                          ),
                        ),
                      ],),

                  ],),
              ),

            ],),
           ] ),
    );
      }
    );
  }
  Widget review(ReviewModel model,  context)=>InkWell(
    onTap: (){
      AppCubit.get(context).getallusersshopreviews(id: AppCubit.get(context).ud);
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 65,width: double.infinity,
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
