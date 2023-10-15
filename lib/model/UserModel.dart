

class UserModel{
   String? email;
   String? uId;
   String? name;
   String? phone;
   String? image;
   String Latitude='';
   String Longitude='';

   UserModel({
     this.name,
     this.phone,
     this.uId,
     this.email,
     this.image,
     required this.Latitude,
     required this.Longitude,


});

   UserModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     phone=json['phone'];
     email=json['email'];
     uId=json['uId'];
     image=json['image'];
     Latitude=json['Latitude'];
     Longitude=json['Longitude'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'phone':phone,
       'email':email,
       'uId':uId,
       'image':image,
       'Latitude':Latitude,
       'Longitude':Longitude,




     };
   }


}