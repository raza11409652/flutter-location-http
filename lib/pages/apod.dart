import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:http/http.dart' as http;
import 'package:location_service/pages/image_preview.dart';
//Apod 
class Apod extends StatefulWidget {
  @override
  _ApodState createState() => _ApodState();
}

class _ApodState extends State<Apod> {
  bool _dataloaded = false ; 
  String _baseURL = "https://api.nasa.gov/planetary/apod?api_key=";
  String _apiKey = "9RX9hLKveSbcyhaY1abJBeYd3q8y0ex1ZeWUocoy";
  String _compeleteUrl =null;

  String _image , _title ,_explanation , _date ,_hdimage; 
  void _calender (context ) async{
    String _day , _month , _year ; 
    CupertinoRoundedDatePicker.show(context , 
      borderRadius: 16,
      initialDatePickerMode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (dateTime)=>{
        // _date = dateTime.,
          _day = dateTime.day.toString() ,
          _month =dateTime.month.toString() ,
          _year = dateTime.year.toString()  , 
          _date = _year + "-"+_month +"-"+_day   ,
          _compeleteUrl = _baseURL + _apiKey+"&date="+_date ,
          print(_compeleteUrl),
          fetchDaata(_compeleteUrl)
          
      }
    ) ;
  }

  
  @override
  void initState() {
    super.initState();
    _dataloaded = false;
    // print(_baseURL + _apiKey);
    _compeleteUrl = _baseURL + _apiKey ; 
    fetchDaata(_compeleteUrl);
  }


  fetchDaata(url) async {
    setState(() {
      _dataloaded = false;
    });
    var _response =  await http.get(url, headers: {
       "Accept":"application/json"
     });
    //  print(_response.statusCode) ; 
    if(_response.statusCode==200){
      String responseBody = _response.body;
      var responseJSON = json.decode(responseBody);
      // print(responseJSON);
       _image = responseJSON['url'];
        _title = responseJSON['title'];
        _explanation = responseJSON['explanation'];
        _date   = responseJSON['date'];
        _hdimage=responseJSON['hdurl'];

     setState(() {
       _dataloaded = true;
     });
      // print(_explanation);

    }else{
      print(_response.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _dataloaded ? _dataUI() :Center(
          child: CircularProgressIndicator(),
        )
    ) ;
  }
  Widget _dataUI(){
    return NestedScrollView(headerSliverBuilder: (BuildContext _ctx , bool isSelected){
        return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("APOD"),
                  background: Image.network(_image , 
                  fit:BoxFit.cover,),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.calendar_today , color: Colors.white,),
                    tooltip: "Select Date",
                    onPressed: (){
                      _calender(context);
                      
                    },
                  )
                ],
              )
            ];
    },
    body: ListView(
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Text(_date , style: TextStyle(color: Colors.deepOrangeAccent),),
        Padding(padding: EdgeInsets.symmetric(
          vertical: 6.0 ,

        )
        ) , 
        Text(_title , style: TextStyle(fontSize: 24.0 , fontWeight: FontWeight.bold),
        ) ,
        Text(_explanation) , 
        Padding(padding: EdgeInsets.symmetric(
          vertical: 10.0
        ) , 
        ) ,
        GestureDetector(
          onTap: (){

              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx)=>ImagePreview(image: _hdimage,))
              ) ; 
          },
            child: Container(
            height: 50.0,
            child: Center(
              child: Text("View HD IMAGE" , style: TextStyle(color: Colors.white),),
            ),
            decoration: BoxDecoration(color: Colors.deepOrangeAccent , 
            borderRadius: BorderRadius.circular(45.0)),
          ),
        )
      ],
    )
    );
  }
}