



import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'constants.dart';

class MongoDatabase{
  static var db, userCollection;
  
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);

  }

  static Future<String> insert(var customer) async {
    try {
      var result = await userCollection.insertOne(customer.toJson());
      if (result.isSuccess){
        return "Data Inserted";
      } else {
        return "Something wrong while adding data";
      }
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  static Future<Map<String,dynamic>> getData(String email, String password) async {
    print("getdata() called in mongodb");
    final arrData = await userCollection.findOne({"email" : email});
    // print(arrData);
    if (arrData != null){
      if (arrData["password"] == password){
        return arrData;
      }
      else{
        return {"error" : "Invalid username or password"};
      }
      
    }
    return {"error" : "Invalid username or password"}; 
  }

}