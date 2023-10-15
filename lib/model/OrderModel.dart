

class OrderModel{
   String? state;
   String? uId;
   String? myId;
   String? name;
   String? phone;
   String? image;
   String Latitude='';
   String Longitude='';

   OrderModel({
     this.name,
     this.phone,
     this.uId,
     this.myId,
     this.state,
     this.image,
     required this.Latitude,
     required this.Longitude,


});

   OrderModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     phone=json['phone'];
     state=json['state'];
     uId=json['uId'];
     myId=json['myId'];
     image=json['image'];
     Latitude=json['Latitude'];
     Longitude=json['Longitude'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'phone':phone,
       'state':state,
       'uId':uId,
       'myId':myId,
       'image':image,
       'Latitude':Latitude,
       'Longitude':Longitude,




     };
   }


}