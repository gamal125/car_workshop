

class ReviewModel{
   String? uId;
   String? name;
   String? uIdpublisher;
   String? Servicename;
   String? image;
   String? image1;
   String? image2;
   String? image3;
   double? rating;
   String? comment;

   ReviewModel({
     this.name,
     this.uId,
     this.uIdpublisher,
     this.Servicename,
     this.image,
     this.image1,
     this.image2,
     this.image3,
      this.rating,
      this.comment,


});

   ReviewModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     rating=json['rating'];
     uIdpublisher=json['uIdpublisher'];
     Servicename=json['Servicename'];
     comment=json['comment'];
     uId=json['uId'];
     image=json['image'];
     image1=json['image1'];
     image2=json['image2'];
     image3=json['image3'];





   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'rating':rating,
       'uIdpublisher':uIdpublisher,
       'Servicename':Servicename,
       'comment':comment,
       'uId':uId,
       'image':image,
       'image1':image1,
       'image2':image2,
       'image3':image3,







     };
   }


}