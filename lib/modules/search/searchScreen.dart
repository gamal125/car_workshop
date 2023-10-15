import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:workshop_app/cubit/cubit.dart';

import '../../components/components.dart';
import '../../model/ServiceModel.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({super.key});
  final  formKey = GlobalKey<FormState>();

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var searchController=TextEditingController();

  List<ServiceModel> searchItems=[];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.blue),elevation: 0,),
        body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
          children: [


          Padding(
          padding: const EdgeInsets.all(8.0),
    child: defaultTextFormField(
    onTap: (){
    setState(() {


    });
    },
    controller: searchController,
    onChanged: searchPhone,
    keyboardType: TextInputType.text,
    prefix: Icons.drive_file_rename_outline,
    label: 'البحث',
    hint: 'البحث',
      validate: (String? value) {
      if (value!.isEmpty) {
          return 'Please enter phone';
      }
      return null;
    },
    ),
    ),
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => gridservice(
                  searchItems[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: searchItems.length,
            ).animate().fade(begin: 0.1,end: 2),

    ]),
        )) ));
  }
  Widget gridservice(ServiceModel model, context) => InkWell(
    onTap: () {

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
                      Text(
                        model.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dubai',
                          color: Colors.black,
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
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${model.price!} \$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dubai',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),





                ],
              ),
            ),
          ],
        ),
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
