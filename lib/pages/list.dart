import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  String name, username, avatar;
  bool isData = false;
  @override
  void initState() {
    super.initState();
    fetchJson();
  }
  fetchJson()async{
    var _response = await http.get("https://api.github.com/users/raza11409652",
     headers: {
       "Accept":"application/json"
     } ) ;
     if(_response.statusCode == 200){
      String responseBody = _response.body;
      var responseJSON = json.decode(responseBody);
      username = responseJSON['login'];
      name = responseJSON['name'];
      avatar = responseJSON['avatar_url'];
      
       setState(() {
         isData = true;
         print(responseBody);
        //  print(username);
        //  print(avatar);
        // print('UI Updated');
      });
     }else{
       print(_response.statusCode);
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JSON Data list"),
      ),
      body: isData?_appUI():new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Widget _appUI(){
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Image.network(avatar ,height: 100,width: 100,),
          new Padding(padding:EdgeInsets.symmetric(vertical: 10.0)),
          new Center(
          child: Text('User name $username' , style: TextStyle(
            fontSize: 16.0 , 
            fontWeight: FontWeight.bold
          ),),
          ) , 
         new Padding(padding:EdgeInsets.symmetric(vertical: 10.0)) , 
         new Center(
           child: Text(name),
         )
        ],
      ),
    ) ; 
  }
}