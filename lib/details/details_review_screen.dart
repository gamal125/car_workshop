import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_app/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class DetailsReview extends StatefulWidget {
  final String uId;
  final String name;
 final String uIdpublisher;
 final String Servicename;
  final String image;
 final String image1;
  final String image2;
  final String image3;
  final double rating;
  final String comment;


   DetailsReview({Key? key,
    required this.image,
     required this.image2,
     required this.image3,
    required this.name,
     required this.Servicename,
    required this.image1,
    required this.uIdpublisher,
    required this.uId,
    required this.rating,
    required this.comment,


  }) : super(key: key);

  @override
  State<DetailsReview> createState() => _DetailsReviewState();
}

class _DetailsReviewState extends State<DetailsReview> {
  @override
  Widget build(BuildContext context) {

List<String> mod=[widget.image1,widget.image2,widget.image3];

    return BlocConsumer<AppCubit, AppStates>(
      listener:(context, state){

      } ,
      builder:(context, state){ return
        Scaffold(
          appBar: AppBar(
            title:  Text(widget.name,style: TextStyle(color: Colors.black),),
            actions: [

              widget.image!=''?
              Container(height: 50,width: 50,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.image),fit: BoxFit.cover),shape: BoxShape.circle),
              )
                  :  Container(height: 50,width: 50,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/1.jpg'),fit: BoxFit.scaleDown),shape: BoxShape.circle),
              ),
              SizedBox(width: 10,),
            ],
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
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                    SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Servicename:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,     style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      ),
                      Text(
                        widget.Servicename,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,     style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                      ),
                    ],
                  ),
                    myDivider(),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rating:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,     style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,color: Colors.indigo,),
                            Text(
                              widget.rating.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,     style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    myDivider(),
                    const SizedBox(height: 10,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "comment:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,     style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        ),

                      ],
                    ),
                    Text(
                      widget.comment,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,     style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                    ),





                  ],),
              ),

            ],),
           ] ),
    );
      }
    );
  }

}
