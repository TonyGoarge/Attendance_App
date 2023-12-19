class Users {
  String? uId;
  String? phone;
  String? name;
  String? email;
  static double lat=0;
  static double long=0;


  Users({
    this.uId,
    this.phone,
    this.name,
    this.email,




  });

  Users.fromjson(Map<String,dynamic>json)
  {
    uId=json['uId'];
    phone=json['phone'];
    name=json['name'];
    email=json['email'];

  }
  Map<String,dynamic>toMap()
  {
    return{
      'uId':uId,
      'phone':phone,
      'name':name,
      'email':email,


    };
  }
}