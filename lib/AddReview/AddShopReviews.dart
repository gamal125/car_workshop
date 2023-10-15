import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/cubit/states.dart';
import 'package:workshop_app/layout/todo_layout.dart';

import '../components/components.dart';

class AddShopReview extends StatelessWidget {
  final String uidPublisher;
  final String shopName;
   AddShopReview({super.key,required this.uidPublisher,required this.shopName});


   final  formKey = GlobalKey<FormState>();
  double ratingvalue=3.0;
  final review = TextEditingController();
 String? image;


  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    var c=AppCubit.get(context);
   if(AppCubit.get(context).userdata!.image==''||AppCubit.get(context).userdata!.image==null){
     image='';
   }else{image=AppCubit.get(context).userdata!.image;}
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
          if(state is AddShopReviewSuccessState){
            AppCubit.get(context).changeIndex(1);
            navigateAndFinish(context, Home_Layout());
          }
        },
      builder: (context, state) {
        var image2=c.PickedFile2;
        var image3=c.PickedFile3;
        var image4=c.PickedFile4;
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.blue),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },

              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(   scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    c.getImage2();
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 250,

                                    decoration: image2 != null ?
                                    BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: FileImage(image2),fit: BoxFit.fill ))
                                        : const BoxDecoration(image: DecorationImage(image: NetworkImage(
                                        'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg') ))
                                    ,
                                  ),
                                ),
                                const SizedBox(width:10,),
                                InkWell(
                                  onTap: (){
                                    c.getImage3();
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 250,

                                    decoration: image3 != null ?
                                    BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: FileImage(image3),fit: BoxFit.fill ))
                                        : const BoxDecoration(image: DecorationImage(image: NetworkImage(
                                        'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg') ))
                                    ,
                                  ),
                                ),
                                const SizedBox(width:10,),
                                InkWell(
                                  onTap: (){
                                    c.getImage4();
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 250,

                                    decoration: image4 != null ?
                                    BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: FileImage(image4),fit: BoxFit.fill ))
                                        : const BoxDecoration(image: DecorationImage(image: NetworkImage(
                                        'https://www.leedsandyorkpft.nhs.uk/advice-support/wp-content/uploads/sites/3/2021/06/pngtree-image-upload-icon-photo-upload-icon-png-image_2047546.jpg') ))
                                    ,
                                  ),
                                ),
                              ],
                            ),),
                          const SizedBox(
                            height: 10,
                          ),

                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              ratingvalue=rating;
                              print(ratingvalue);
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          defaultTextFormField2(
                            onTap: (){
                            },
                            controller: review,
                            keyboardType: TextInputType.text,
                            prefix: Icons.edit,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter Review';
                              }
                              return null;
                            },
                            label: 'Review',
                            hint: 'Enter your Review',
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! AddServiceReviewLoadingState,
                            builder: (context) => Center(
                              child: defaultMaterialButton(

                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    if(c.PickedFile2!=null){
                                    if(c.PickedFile3==null){
                                      c.PickedFile3=c.PickedFile2;
                                    }
                                    if(c.PickedFile4==null){
                                      c.PickedFile4=c.PickedFile2;
                                    }
                                                AppCubit.get(context).addshopreview(
                                                    image: image!,
                                                    serviceName: shopName,
                                                    uidPublisher: uidPublisher,
                                                    rate: ratingvalue,
                                                    comment: review.text, id: uidPublisher, name: shopName);}else{
                                      showToast(text:'please insert picture first', state: ToastStates.error);
                                    }
                                  }
                                },
                                text: 'Post',
                                radius: 20,
                              ),
                            ),
                            fallback: (context) {

                          return
                                Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.blue.withOpacity(.8),
                                      size: screenSiz.width / 12,
                                    ));}
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }
}
