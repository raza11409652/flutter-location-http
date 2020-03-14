import '../DataModel/UserModel.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
class UserListService{
  String URL = "https://next.json-generator.com/api/json/get/VkUgttBB_";
  UserModel _userModel ; 
  UserListService(){
      
  }
  Future<List<UserModel>>getUser() async{
    var _response =  await http.get(Uri.encodeFull(URL) , headers: {
      "Accept":"application/json"
    }) ; 
    var  map = json.decode(_response.body);
    // print(map);
      List<UserModel> list =[];
    for(var u in map){
      //  print(u);
      var name =null; 
      var _first = u['name']['first'] ; 
      var _last = u['name']['last'] ; 
      name = _first +" "+_last; 
      // print(name);
       var image =  u['picture'];
       var email = u['email']; 
       var phone = u['phone']  ; 
       var address = u['address'];
      //  print(image);
      UserModel user = UserModel(name, address, phone, email, image) ; 
      list.add(user);
    }
    // print(list);
    
  
     return list ; 
  }
}