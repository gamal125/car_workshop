import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/model/ReviewModel.dart';

import '../../components/components.dart';
import '../../model/ServiceModel.dart';

class AllUserShopReviewsScreen extends StatefulWidget {
  AllUserShopReviewsScreen({super.key});
  final  formKey = GlobalKey<FormState>();

  @override
  State<AllUserShopReviewsScreen> createState() => _AllUserShopReviewsScreenState();
}

class _AllUserShopReviewsScreenState extends State<AllUserShopReviewsScreen> {

  var searchController=TextEditingController();

  List<ServiceModel> searchItems=[];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.blue),title: Center(child: Text('All Reviews',style: TextStyle(color: Colors.black),)),elevation: 0,),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: Form(
                  key: widget.formKey,
                  child: Column(
                      children: [



                        ConditionalBuilder(
                          condition: AppCubit.get(context).AllshopReviews.isNotEmpty,
                          builder:(context)=> ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => review(
                                AppCubit.get(context).AllshopReviews[index], context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: AppCubit.get(context).AllshopReviews.length,
                          ).animate().fade(begin: 0.1,end: 2), fallback: (BuildContext context) =>Center(child: CircularProgressIndicator(),),
                        ),

                      ]),
                )) ));
  }
  Widget review(ReviewModel model,  context)=>InkWell(
    onTap: (){
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 58,width: double.infinity,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${model.name!} (${model.Servicename})',maxLines: 1,overflow: TextOverflow.ellipsis,),
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

  void searchPhone(String query){
    final suggest=AppCubit.get(context).services.where((book){
      final phonetitle=book.name!.toLowerCase();
      final input=query.toLowerCase();
      return phonetitle.contains(input);



    }).toList();

    setState(() {
      searchItems=suggest;
    });
  }
}
