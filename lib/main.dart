import 'package:flutter/material.dart';
import 'package:location_service/DataModel/UserLocation.dart';
import 'package:location_service/pages/apod.dart';
import 'package:location_service/pages/dictionary.dart';
import 'package:location_service/pages/list.dart';
import 'package:location_service/pages/user_list.dart';
// import 'package:location_service/utils/alter.dart';
import 'package:provider/provider.dart';
import 'Services/location_services.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<UserLocation>(
       create: (context) => LocationService().locationStream,
       child: MaterialApp(
         title: "App location test",
         theme: ThemeData(
           primarySwatch: Colors.blue
         ),
         home:  HomeView(),
       ),
    );
  }
}
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  Alert _alert = new Alert(context);
    var userLocation = Provider.of<UserLocation>(context);
   
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Text('Location :latitude ${userLocation?.latitude} , longitude ${userLocation?.longitude}'),
          RaisedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext ctx)=>ListItem())
            );
          } , 
          child: Text("Next Page JSON Data"),

          ) ,
         Center(
           child:  MaterialButton(onPressed: (){
             Navigator.of(context).push(
               MaterialPageRoute(builder: (BuildContext ctx)=>Apod())
             ) ; 
           } , 
            textColor: Colors.blueAccent,
            child: Text("APOD-Astronomy Picture of the Day"),
          ),
         ) , 
         RaisedButton(onPressed: (){
           Navigator.of(context).push(
               MaterialPageRoute(builder: (BuildContext ctx)=>UserList())
             );
         } , 
         child: Text("User list"),
         ) , 
         MaterialButton(onPressed: (){
           Navigator.of(context).push(
               MaterialPageRoute(builder: (BuildContext ctx)=>Dictionary())
             );
         } , 
         textColor: Colors.white,
          child: Text("Dictionary"),
          color: Colors.deepPurple,
         )
        ],
      ),
    );
  }
}