import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/cubit/cubit.dart';
import 'package:workshop_app/cubit/states.dart';
import 'package:workshop_app/layout/todo_layout.dart';
import '../../../components/components.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final  formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final phoneController = TextEditingController();
   String selectedOption='Riyadh';
  String selectedOption2='Windows tint';
  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    var c= AppCubit.get(context);
    return  BlocConsumer<AppCubit, AppStates>(
        listener:(context, state){
          if(state is GetServiceSuccessStates){
            navigateAndFinish(context, Home_Layout());}
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
                                    padding: const EdgeInsets.only(right: 10,left: 10,bottom:10),
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
                                        label: 'offer name',
                                        hint: 'insert offer name',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      defaultTextFormField(
                                        onTap: (){

                                        },
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        prefix: Icons.attach_money_rounded,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter price ';
                                          }
                                          return null;
                                        },
                                        label: 'price',
                                        hint: 'insert price',
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
                                      ),   Padding(
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
                                                          value: 'Windows tint',
                                                          child: Text('Windows tint'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Car wash',
                                                          child: Text('Car wash'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Polish',
                                                          child: Text('Polish'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Protection',
                                                          child: Text('Protection'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'Nano',
                                                          child: Text('Nano'),
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
                                              AppCubit.get(context).Alltokens.isNotEmpty? AppCubit.get(context).sendAllNotifcations(selectedOption2):(){};
                                              c.uploadserviceImage(
                                                name: nameController.text,
                                                desc: descController.text,
                                                phone: phoneController.text,
                                                location: selectedOption,
                                                price: priceController.text, type: selectedOption2,);
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
                                                ));
                                      })
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
