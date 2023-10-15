import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workshop_app/cubit/states.dart';
import 'package:workshop_app/model/OrderModel.dart';
import 'package:workshop_app/model/ReviewModel.dart';
import 'package:workshop_app/model/WorkshopModel.dart';
import 'package:workshop_app/modules/workshop_app/offers/offers.dart';
import 'package:workshop_app/modules/workshop_app/towing/towing.dart';
import 'package:workshop_app/modules/workshop_app/workshops/workshops.dart';
import 'package:workshop_app/shared/local/cache_helper.dart';
import 'package:http/http.dart';
import '../model/ServiceModel.dart';
import '../model/UserModel.dart';
import '../model/token_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    Offers_Screen(),
    Work_Shops_Screen(),
    Towing_Screen(),
  ];
  List<String> titles = [
    'offers',
    'work shops',
    'towing',
  ];
  List<BottomNavigationBarItem> BottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.local_offer,
        ),
        label: 'offers'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.car_crash,
        ),
        label: 'work shops'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/icon/shipping.svg',width:24,height: 24,color: Colors.black54,),
        label: 'towing'),

  ];
  void signout(){
    emit(LogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
    });
  }
  String? token;
  Future<String> getMytoken() async {
    String? token=await FirebaseMessaging.instance.getToken();
    return token!;
  }
  Future<void> senddeleteNotification(String token) async {
    this.token;
    try {
      final body =
      {
        "to": token,
        "notification": {
          "title": "${userdata!.name!}",
          "body": "customers want delete hes account",
          "sound": "defualt"
        },
        "android": {
          "priority": "HIGH",
          "notification":
          {
            "notification_priority": "PRIORITY_MAX",
            "sound": "defualt",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "data": {
          "type": "XX",
          "id": "IKO",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      };

      var response = await post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders
                .authorizationHeader: 'key=AAAA3XCCWB0:APA91bGV_Fy-HePjQbkN0zNULdgV5b35NeyXU_LHLPCig1FAn_lfX_rdXEFwys17Q9TS2D8qi7vZlCtAOL68KQj2ra_mlqoF0AwhUYCyuuZpEhk14ISQ-Gotu60HsGWVKmfxzrOf8dDC'
          },
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {

    }
  }
  List<tokenModel> Alltokens=[];

  void gettokens(){
    Alltokens.clear();
    FirebaseFirestore.instance.collection('token').get().then((value){
      value.docs.forEach((element) {
        Alltokens.add(tokenModel.fromjson(element.data()));
      });
    });
  }
  void sendAllNotifcations(String offer ){

    Alltokens.forEach((element) {
      print(element.token);
      sendNotification(element.token!,offer);
    });
  }
  Future<void> sendNotification(String token,String offer) async {


    try {
      final body =
      {
        "to":token,
        "notification": {
          "title": "Repair Right",
          "body": "New $offer offer",
          "sound": "defualt"
        },
        "android": {
          "priority": "HIGH",
          "notification":
          {
            "notification_priority": "PRIORITY_MAX",
            "sound": "defualt",
            "default_sound": true,
            "default_vibrate_timings": true,
            "default_light_settings": true
          }
        },
        "data": {
          "type": "XX",
          "id": "IKO",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      };

      var response = await post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders
                .authorizationHeader: 'key=AAAA3XCCWB0:APA91bGV_Fy-HePjQbkN0zNULdgV5b35NeyXU_LHLPCig1FAn_lfX_rdXEFwys17Q9TS2D8qi7vZlCtAOL68KQj2ra_mlqoF0AwhUYCyuuZpEhk14ISQ-Gotu60HsGWVKmfxzrOf8dDC'
          },
          body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {

    }
  }
  String finnaltoken="";
  tokenModel? geted_Admin_token;
  void setToken(String uId)async{
    String? token=await FirebaseMessaging.instance.getToken();
    print("my token $token");
  tokenModel model=tokenModel(
    token:token
  );
    await FirebaseFirestore.instance.collection("token").doc(uId).set(model.Tomap());
  }

  UserModel? userdata;
  void deleteService({required String name,required String id}){
    emit(DeleteServiceLoadingState());
    FirebaseFirestore.instance.collection("offers").doc(id).collection(id).doc(name).delete().then((value) {
      emit(DeleteServiceSuccessState());
      getAllServices();


    });
  }
  void deleteWorkShop({required String name,required String id}){
    emit(DeleteWorkLoadingState());
    deleteReviews(name: name, id: id);
    FirebaseFirestore.instance.collection("category").doc(id).collection(id).doc(name).delete().then((value) {

      emit(DeleteWorkSuccessState());

      getAllWorkShops();


    });
  }
 void deleteReviews ({required String name,required String id}){
  FirebaseFirestore.instance.collection("category").doc(id).collection(id).doc(name).collection('reviews').get().then((value) {
    value.docs.forEach((element) {
      FirebaseFirestore.instance.collection("category").doc(id).collection(id).doc(name).collection('reviews').doc(element.id).delete();
    });
  });
}
  void getUser(uid) {
    FirebaseFirestore.instance.collection('users').doc(uid.toString())
        .get()
        .then((value) {
      print(value.data());
      userdata = UserModel.fromjson(value.data()!);
      print(userdata!.email!);
    });
  }
  void updateProfile({
    required String image,
    required String name,
    required String phone,
    required String email,}) {
    UserModel model = UserModel(
        image: image,
        name: name,
        uId: ud,
        phone: phone,
        email: email,
        Longitude: '',
        Latitude: ''
    );
    emit(ImageintStates());
    FirebaseFirestore.instance.collection('users').doc(ud).update(model.Tomap()).then((value) {
      emit(UpdateProductSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile2!.path)
        .pathSegments
        .last}').putFile(PickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl2 = value;
        print(ImageUrl2);
        createUser(
            image: ImageUrl2,
            name: name,
            email: email,
            phone: phone,
            uId: ud);
        PickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createUser({
    required String image,
    required String email,
    required String uId,
    required String name,
    required String phone,
  }) {
    UserModel model=UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        image: image,
        Longitude: '', Latitude: ''

    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(model.Tomap()).then((value) {

      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex==0){getAllServices();}
    if (currentIndex==1){getAllWorkShops();}
    if (currentIndex==2){getLocation();}


    emit(AppChangeBottomNavBarState());
  }
/////////////////////////iamge///////////
  final ImagePicker picker4 = ImagePicker();
  File? PickedFile4;
  Future<void> getImage4() async {
    final imageFile = await picker4.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile4 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  ///////////////////////////////////
  final ImagePicker picker3 = ImagePicker();
  File? PickedFile3;
  Future<void> getImage3() async {
    final imageFile = await picker3.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile3 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  ///////////////////////////////////////////
  final ImagePicker picker2 = ImagePicker();
  File? PickedFile2;
  Future<void> getImage2() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile2 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  final ImagePicker picker = ImagePicker();
  File? PickedFile;
  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  ////////////////////upload workshop/////////////
  String ImageUrl = '';
  String ud =  CacheHelper.getData(key: 'uId');

  uploadWorkshopImage({
    required String name,
    required String desc,
    required String phone,
    required String location,
    required String type,
  }) {
    emit(ImageintStates());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(PickedFile2!.path).pathSegments.last}')
        .putFile(PickedFile2!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        String imageUrl1 = value;

        // Upload second image
        FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(PickedFile3!.path).pathSegments.last}')
            .putFile(PickedFile3!)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            String imageUrl2 = value;

            // Upload third image
            FirebaseStorage.instance
                .ref()
                .child('users/${Uri.file(PickedFile4!.path).pathSegments.last}')
                .putFile(PickedFile4!)
                .then((value) {
              value.ref.getDownloadURL().then((value) {
                String imageUrl3 = value;

                // Call createworkshop function with the image URLs
                createworkshop(
                  image1: imageUrl1,
                  image2: imageUrl2,
                  image3: imageUrl3,
                  name: name,
                  desc: desc,
                  phone: phone,
                  location: location,
                  type: type,
                );

                PickedFile2 = null;
                PickedFile3 = null;
                PickedFile4 = null;
                emit(ImageSuccessStates());
              }).catchError((error) {
                emit(ImageErrorStates(error));
              });
            }).catchError((error) {
              emit(ImageErrorStates(error));
            });
          }).catchError((error) {
            emit(ImageErrorStates(error));
          });
        }).catchError((error) {
          emit(ImageErrorStates(error));
        });
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createworkshop({
    required String name,
    required String desc,
    required String phone,
    required String location,
    required String type, required String image1, required String image2, required String image3,
  }) {
    WorkshopModel model = WorkshopModel(
      rate: '0.0',
        phone:phone ,
        name: name,
        description: desc,
        image: image1,
        image2: image2,
        image3: image3,
        location: location,
        type: type,
        uId:ud

    );


    FirebaseFirestore.instance.collection("category").doc(ud).collection(ud)
        .doc(name).set(model.Tomap())
        .then((value) {
          getAllWorkShops();
      emit(CreateworkshopSuccessState());
    }).catchError((error) {
      emit(CreateworkshopErrorStates(error.toString()));});


  }
///////////////////get workshops/////////////
  void getAllWorkShops(){
    workshops.clear();
    AllUsers.forEach((element) {
      getworkshop( element.uId!);
    });
  }
  void getworkshop(String id) {

    FirebaseFirestore.instance.collection('category').doc(id)
        .collection(id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        workshops.add(WorkshopModel.fromjson(element.data()));
      });

      emit(GetworkshopsSuccessStates());
    }).catchError((error) {
      emit(GetworkshopsStates(error.toString()));
    });
  }
  /////////////////////////////////getAllServices//////////////////////////////////
  List<WorkshopModel> workshops=[];
  List<WorkshopModel> paintAndBodyWorks=[];
  List<WorkshopModel> tireJobs=[];
  List<WorkshopModel> performanceJobs=[];
  List<WorkshopModel> quickService=[];
  List<ServiceModel> services=[];
  List<ServiceModel> windowsTintServices=[];
  List<ServiceModel> carWashServices=[];
  List<ServiceModel> polishServices=[];
  List<ServiceModel> protectionServices=[];
  List<ReviewModel> serviceReviews=[];
  List<ReviewModel> shopReviews=[];
  List<ServiceModel> nanoServices=[];
  List<UserModel> AllUsers=[];

  void getAllServices(){
    services.clear();
    for (var element in AllUsers) {
      getServices( element.uId!);
    }
    print(services.length);


  }
  void getServices(String id) {
emit(GetServiceLoadingStates());
      FirebaseFirestore.instance.collection('offers').doc(id)
        .collection(id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        services.add(ServiceModel.fromjson(element.data()));
      });
      emit(GetServiceSuccessStates());

    }).catchError((error) {
      emit(GetServiceStates(error.toString()));
    });
  }
  void getServicesReviews(String id,String name) {
    serviceReviews=[];
    emit(GetServiceReviewsLoadingStates());
    FirebaseFirestore.instance.collection('offers').doc(id).collection(id).doc(name).collection('reviews').get()
        .then((value) {
      value.docs.forEach((element) {
        serviceReviews.add(ReviewModel.fromjson(element.data()));
      });
      emit(GetServiceReviewsSuccessStates());

    }).catchError((error) {
      emit(GetServiceStates(error.toString()));
    });
  }
  //////////////////////////////getShopReviews////////////////////////////////////
  void getShopReviews(String id,String name) {
    shopReviews=[];
    emit(GetShopReviewsLoadingStates());
    FirebaseFirestore.instance.collection('category').doc(id).collection(id).doc(name).collection('reviews').get()
        .then((value) {
      value.docs.forEach((element) {
        shopReviews.add(ReviewModel.fromjson(element.data()));
      });
      emit(GetShopReviewsSuccessStates());

    }).catchError((error) {
      emit(GetServiceStates(error.toString()));
    });
  }
  //////////////////////////////create service/////////////////////////////
  String ImageUrl2 = '';
  uploadserviceImage({
    required String name,

    required String desc,
    required String phone,
    required String location,
    required String price,
    required String type,
  }) {
    emit(ImageintStates());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(PickedFile2!.path).pathSegments.last}')
        .putFile(PickedFile2!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        String imageUrl1 = value;

        // Upload second image
        FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(PickedFile3!.path).pathSegments.last}')
            .putFile(PickedFile3!)
            .then((value) {
          value.ref.getDownloadURL().then((value) {
            String imageUrl2 = value;

            // Upload third image
            FirebaseStorage.instance
                .ref()
                .child('users/${Uri.file(PickedFile4!.path).pathSegments.last}')
                .putFile(PickedFile4!)
                .then((value) {
              value.ref.getDownloadURL().then((value) {
                String imageUrl3 = value;

                // Call createworkshop function with the image URLs
                createservice(
                  selectedOption2:type,
                  image1: imageUrl1,
                  image2: imageUrl2,
                  image3: imageUrl3,
                  name: name,
                  desc: desc,
                  phone: phone,
                  location: location,
                  type: type, price: price,
                );

                PickedFile2 = null;
                PickedFile3 = null;
                PickedFile4 = null;
                emit(ImageSuccessStates());
              }).catchError((error) {
                emit(ImageErrorStates(error));
              });
            }).catchError((error) {
              emit(ImageErrorStates(error));
            });
          }).catchError((error) {
            emit(ImageErrorStates(error));
          });
        }).catchError((error) {
          emit(ImageErrorStates(error));
        });
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createservice({
    required String name,
    required String selectedOption2,
    required String desc,
    required String phone,
    required String location,
    required String price,
    required String type, required String image1, required String image2, required String image3,
  }) {
    ServiceModel model = ServiceModel(
        rate: '0.0',
        phone:phone ,
        name: name,
        description: desc,
        image2: image2,
        image3: image3,
        image: image1,
        location: location,
        uId:ud,
        price: price,
      type: type,

    );
    FirebaseFirestore.instance.collection("offers").doc(ud).collection(ud)
        .doc(name).set(model.Tomap())
        .then((value) {
 Alltokens.isNotEmpty?sendAllNotifcations(selectedOption2):(){};
      getAllServices();
      emit(CreateServicesSuccessState());
    }).catchError((error) {
      emit(CreateServicesErrorStates(error.toString()));});


  }
  ////////////////////////////////get users////////////////
  void getusers() {
    AllUsers.clear();

    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {


        AllUsers.add(UserModel.fromjson(element.data()));

      }
      emit(GetUsersSuccessStates());
      print(AllUsers.length);

    });
  }
  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10000000) + 1;
  }
  /////////////////////////////add review //////////////////
  uploadReviewImages({
    required String serviceName,
    required String image,
    required String uidPublisher,
    required double rate,
    required String comment,
  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri.file(PickedFile2!.path).pathSegments.last}').putFile(PickedFile2!).then((value) {value.ref.getDownloadURL().then((value) {
        String imageUrl1 = value;

        // Upload second image
        FirebaseStorage.instance.ref().child('users/${Uri.file(PickedFile3!.path).pathSegments.last}').putFile(PickedFile3!).then((value) {value.ref.getDownloadURL().then((value) {
            String imageUrl2 = value;

            // Upload third image
            FirebaseStorage.instance.ref().child('users/${Uri.file(PickedFile4!.path).pathSegments.last}').putFile(PickedFile4!).then((value) {
              value.ref.getDownloadURL().then((value) {
                String imageUrl3 = value;

                // Call createworkshop function with the image URLs
                addservicereview(
                  image1: imageUrl1,
                  image2: imageUrl2,
                  image3: imageUrl3,
                  serviceName: serviceName,
                  image: image,
                  uidPublisher: uidPublisher,
                  rate: rate,
                  comment: comment,
                );

                PickedFile2 = null;
                PickedFile3 = null;
                PickedFile4 = null;
                emit(ImageSuccessStates());
              }).catchError((error) {emit(ImageErrorStates(error));});
            }).catchError((error) {
              emit(ImageErrorStates(error));
            });
          }).catchError((error) {
            emit(ImageErrorStates(error));
          });
        }).catchError((error) {
          emit(ImageErrorStates(error));
        });
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });}).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void addservicereview({
    required String image1,
    required String image2,
    required String image3,
    required String image,
    required String serviceName,
    required String uidPublisher,
    required double rate,
    required String comment,
  }) {
     ud =  CacheHelper.getData(key: 'uId');

    ReviewModel model = ReviewModel(
      image1: image1,
      image2: image2,
      image3: image3,
        image: image,
        uIdpublisher: uidPublisher,
        Servicename: serviceName,
        name: userdata!.name,
        uId: ud,
        rating: rate,
        comment: comment,
    );

    FirebaseFirestore.instance.collection('offers').doc(uidPublisher).collection(uidPublisher).doc(serviceName).collection('reviews').doc(ud).set(model.Tomap());
    FirebaseFirestore.instance.collection('users').doc(ud).collection("reviews").doc('${generateRandomNumber()}').set(model.Tomap()).then((value) {
      emit(AddServiceReviewSuccessState());
    });


  }
  /////////////////////////addshopreview//////////////////////////
  void addshopreview({
    required String id,
    required String name,
    required String image,
    required String serviceName,
    required String uidPublisher,
    required double rate,
    required String comment,
  }) {
    ud =  CacheHelper.getData(key: 'uId');

    ReviewModel model = ReviewModel(
      image: image,
      uIdpublisher: uidPublisher,
      Servicename: serviceName,
      name: userdata!.name,
      uId: ud,
      rating: rate,
      comment: comment,
    );
    emit(AddShopReviewLoadingState());
    FirebaseFirestore.instance.collection('category').doc(uidPublisher).collection(uidPublisher).doc(serviceName).collection('reviews').doc(ud).set(model.Tomap());
    FirebaseFirestore.instance.collection('users').doc(ud).collection("shopreviews").doc('${generateRandomNumber()}').set(model.Tomap()).then((value) {
    getShopReviews(id, name);
      emit(AddShopReviewSuccessState());
    });


  }
///////////////////////get all reviews////////////////
  List<ReviewModel> AllReviews=[];
  List<ReviewModel> AllshopReviews=[];
void getallusersreview({required String id}){
  AllReviews.clear();
  emit(GetAllServiceReviewLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).collection('reviews').get().then((value) {
      value.docs.forEach((element) {
        AllReviews.add(ReviewModel.fromjson(element.data()));
      });
      emit(GetAllServiceReviewSuccessState());

    });
}
  void getallusersshopreviews({required String id,}){
    AllshopReviews.clear();
    emit(GetAllShopReviewLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).collection('shopreviews').get().then((value) {
      value.docs.forEach((element) {
        AllshopReviews.add(ReviewModel.fromjson(element.data()));
      });
      emit(GetAllShopReviewSuccessState());

    });
  }
  /////////////////////////addtowing/////////////////
void addtowing({required String Latitude,required String Longitude}){
  UserModel model=UserModel(
    Latitude: Latitude,
    Longitude: Longitude,
    name: userdata!.name,
    image:userdata!.image ,
    email: userdata!.email,
    phone:userdata!.phone ,
    uId: ud,
  );
  emit(AddTowingLoadingState());
  FirebaseFirestore.instance.collection('towing').doc(ud).set(model.Tomap()).then((value) {
    emit(AddTowingSuccessState());
    gettowingitself();
  });
}
  UserModel? TowingUser;

  void gettowingitself(){

    emit(GetTowingItSelfLoadingState());

    FirebaseFirestore.instance.collection('towing').doc(ud).get().then((value) {
      TowingUser=UserModel.fromjson(value.data()!);
      emit(GetTowingItSelfSuccessState());
    }).catchError((error){
      emit(GetTowingItSelfSuccessState());

    });
  }

  String Latitude = '';
  String longitude = '';

  Future<void> getLocation() async {
    // Check if location permissions are granted
    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );


      Latitude = position.latitude.toString();
      longitude= position.longitude.toString();
      emit(GetLocationSuccessState());

    } else {
      // Request location permissions
      PermissionStatus permissionStatus = await Permission.location.request();

      if (permissionStatus.isGranted) {
        // Permission granted, retrieve location
        await getLocation();
      } else {
        // Permission denied

        Latitude = '';

      }
    }
  }
  List<UserModel> AllTowing=[];
  void getAllTowing(){
    AllTowing.clear();
    emit(GetAllTowingLoadingState());
    FirebaseFirestore.instance.collection("towing").get().then((value) {
      value.docs.forEach((element) {
        AllTowing.add(UserModel.fromjson(element.data()));
      });
      emit(GetAllTowingSuccessState());

    });
  }
  void userorderingtowing({
    required String name,
    required String image,
    required String uid,
    required String phone,
    required String Latitude,
    required String longitude,

  }){
    OrderModel model=OrderModel(
        Latitude: Latitude,
        Longitude: longitude,
        name:name,
        image:image,
        uId:uid,
        myId: ud,
        phone:phone,
      state: 'waiting'
    );
    FirebaseFirestore.instance.collection("users").doc(ud).collection('orders').doc(uid).set(model.Tomap());
    userorderingtowing2(
        name: userdata!.name!,
        image: userdata!.image!,
        uid: uid,
        phone:userdata!.phone!,
        Latitude: Latitude,
        longitude:longitude);
  }
  void userorderingtowing2({
    required String name,
    required String image,
    required String uid,
    required String phone,
    required String Latitude,
    required String longitude,

  }){
    OrderModel model=OrderModel(
      Latitude: Latitude,
      Longitude: longitude,
      name:name,
      image:image,
      myId: uid,
      uId:ud,
      phone:phone,
      state: 'waiting'
    );
    FirebaseFirestore.instance.collection("orders").doc(uid).collection('orders').doc(ud).set(model.Tomap());
    emit(OrderingSuccessState());

  }
  /////////////get MyOrders///////////////
  List<OrderModel> MyOrders=[];
  List<OrderModel> ALlOrders=[];
  List<OrderModel> MyTowingOrders=[];
  void getmyorders(){
    MyOrders.clear();
    ALlOrders.clear();
    MyTowingOrders.clear();
    FirebaseFirestore.instance.collection('users').doc(ud).collection('orders').get().then((value) {
      value.docs.forEach((element) {
        ALlOrders.add(OrderModel.fromjson(element.data()));
      });
      ALlOrders.forEach((element) { if(element.state=='waiting'){
        MyOrders.add(element);}else{
        MyTowingOrders.add(element);
      }


      });
      emit(GetMyOrdersSuccessState());
    });
  }
  void gettowingmyorders(){
    MyOrders.clear();
    ALlOrders.clear();
    MyTowingOrders.clear();
    FirebaseFirestore.instance.collection('orders').doc(ud).collection('orders').get().then((value) {
      value.docs.forEach((element) {
        ALlOrders.add(OrderModel.fromjson(element.data()));
      });
      ALlOrders.forEach((element) { if(element.state=='waiting'){
MyOrders.add(element);}else{
        MyTowingOrders.add(element);
      }


      });

      emit(GetMyOrdersSuccessState());
    });
  }
  void declineorders({required String id}){
    emit(DeclineOrdersLoadingState());
    FirebaseFirestore.instance.collection("users").doc(id).collection('orders').doc(ud).delete();
    emit(DeclineOrdersSuccessState());

    FirebaseFirestore.instance.collection('orders').doc(ud).collection('orders').doc(id).delete().then((value) {
      gettowingmyorders();
    });
  }
  void acceptinguserorderingtowing({
    required String name,
    required String image,
    required String uid,
    required String phone,
    required String Latitude,
    required String longitude,

  }){
    OrderModel model=OrderModel(
        Latitude: Latitude,
        Longitude: longitude,
        name:userdata!.name!,
        image:userdata!.image!,
        uId:ud,
        myId: uid,
        phone:userdata!.phone!,
        state: 'accepted'
    );
    FirebaseFirestore.instance.collection("users").doc(uid).collection('orders').doc(ud).set(model.Tomap());
    acceptinguserorderingtowing2(
        name: name,
        image: image,
        uid: uid,
        phone:phone,
        Latitude: Latitude,
        longitude:longitude);
  }
  void acceptinguserorderingtowing2({
    required String name,
    required String image,
    required String uid,
    required String phone,
    required String Latitude,
    required String longitude,

  }){
    OrderModel model=OrderModel(
        Latitude: Latitude,
        Longitude: longitude,
        name:name,
        image:image,
        uId:uid,
        myId: ud,
        phone:phone,
        state: 'accepted'
    );
    FirebaseFirestore.instance.collection("orders").doc(ud).collection('orders').doc(uid).set(model.Tomap()).then((value) {
      emit(OrderingSuccessState());
      gettowingmyorders();

    });


  }
}
