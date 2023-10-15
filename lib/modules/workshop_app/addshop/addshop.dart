import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/cubit/states.dart';
import 'package:workshop_app/layout/todo_layout.dart';
import '../../../components/components.dart';

class AddShop extends StatefulWidget {
  const AddShop({super.key});

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  final  formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final phoneController = TextEditingController();
   String selectedOption='Riyadh';
  String selectedOption2='Paint and bodyworks';

  @override
  Widget build(BuildContext context) {
    var c= AppCubit.get(context);
    Size screenSiz = MediaQuery.of(context).size;
    return  BlocConsumer<AppCubit, AppStates>(
        listener:(context, state){
          if(state is GetworkshopsSuccessStates){
            navigateAndFinish(context, Home_Layout());
          }
        },
      builder:(context, state)
        {
          var image=c.PickedFile2;
          var image3=c.PickedFile3;
          var image4=c.PickedFile4;
          return Scaffold(
          appBar: AppBar(iconTheme: const IconThemeData(color: Colors.blue),backgroundColor: Colors.white,elevation: 0,),
          body: Container(
            decoration:  const BoxDecoration(
          color: Colors.white60

            ),
            child: GestureDetector(
              onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(

                            child: Column(
                              children: [

                                Container(
                                  decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20,left: 20,bottom:10),
                                    child: Column(children: [

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

                                                decoration: image != null ?
                                                BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: FileImage(image),fit: BoxFit.fill ))
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
                                        height: 20,
                                      ),
                                      defaultTextFormField(
                                        onTap: (){

                                        },
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        prefix: Icons.person,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter name ';
                                          }
                                          return null;
                                        },
                                        label: 'workshop name',
                                        hint: 'insert workshop name',
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      defaultTextFormField(
                                        onTap: (){

                                        },
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        prefix: Icons.phone,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter phone ';
                                          }
                                          return null;
                                        },
                                        label: 'phone number',
                                        hint: '05XXXXXXXX',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                                            child: Text(
                                              'Description',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.cyan),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                            child: TextField(

                                              maxLines: 5,
                                              controller: descController,
                                              decoration: const InputDecoration(

                                                hintText: 'Enter description',
                                                enabledBorder:OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                  child: Text(
                                                    'Select an location',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.cyan),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(12)),

                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                    child: DropdownButton<String>(
                                                      value: selectedOption,
                                                      hint: const Text('Choose an location'),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedOption = newValue!;
                                                        });
                                                      },
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'Riyadh',
                                                          child: Text('Riyadh'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Khobar',
                                                          child: Text('Khobar'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Jeddah',
                                                          child: Text('Jeddah'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Qassim',
                                                          child: Text('Qassim'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                  child: Text(
                                                    'Select type',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.cyan),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(12)),

                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                    child: DropdownButton<String>(
                                                      value: selectedOption2,
                                                      hint: const Text('Choose type'),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedOption2 = newValue!;
                                                        });
                                                      },
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'Paint and bodyworks',
                                                          child: Text('Paint and bodyworks'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Tire jobs',
                                                          child: Text('Tire jobs'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Performance jobs',
                                                          child: Text('Performance jobs'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Quick service',
                                                          child: Text('Quick service'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ConditionalBuilder(condition: state is! ImageintStates, builder: (context){return defaultMaterialButton(function: (){
                                        if (formKey.currentState!.validate()) {
                                          if(c.PickedFile2!=null) {
                                            if(c.PickedFile3==null){
                                              c.PickedFile3=c.PickedFile2;
                                            }
                                            if(c.PickedFile4==null){
                                              c.PickedFile4=c.PickedFile2;
                                            }
                                            if (phoneController.text.length < 11) {
                                              c.uploadWorkshopImage(
                                                name: nameController.text,
                                                desc: descController.text,
                                                phone: phoneController.text,
                                                location: selectedOption, type: selectedOption2,);
                                            } else {
                                              showToast(text:'phone must be only 10 no.', state: ToastStates.error);

                                            }
                                          }else{
                                            showToast(text:'please insert picture first', state: ToastStates.error);
                                          }
                                        }

                                      }, text: 'post');},
                                          fallback: (context){return

                                            Center(
                                                child: LoadingAnimationWidget.inkDrop(
                                                  color: Colors.blue.withOpacity(.8),
                                                  size: screenSiz.width / 12,
                                                ));})




                                    ]),

                                  ),


                                ),


                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      );}
    );
  }
}
