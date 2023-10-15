

class ServiceModel{
   String? rate;
   String? uId;
   String? name;
   String? phone;
   String? image;
   String? image2;
   String? image3;
   String? price;
   String? description;
   String? location;
   String? type;


   ServiceModel({
     this.name,
     this.phone,
     this.uId,
     this.rate,
     this.image,
     this.image2,
     this.image3,
     this.description,
     this.price,
     this.location,
     this.type,



   });

   ServiceModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     phone=json['phone'];
     rate=json['rate'];
     uId=json['uId'];
     image=json['image'];
     image2=json['image2'];
     image3=json['image3'];
     description=json['description'];
     price=json['price'];
     location=json['location'];
     type=json['type'];





   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'phone':phone,
       'rate':rate,
       'uId':uId,
       'image':image,
       'image2':image2,
       'image3':image3,
       'description':description,
       'price':price,
       'location':location,
       'type':type,




     };
   }


}