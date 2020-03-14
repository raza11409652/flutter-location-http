import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
class Dictionary extends StatefulWidget {
  
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
   String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = "a9f06d5b4196bf549583a3108e1c8aaff290f205";
  TextEditingController _searchController = TextEditingController() ; 
  StreamController _streamController ; 
  Stream _stream ;
  _search() async {
    // if(_searchController.text == null ){
    //   _streamController.add(null);
    // }

    // print(_url);
    // _streamController.add("waiting");
    http.Response response  = await http.get(_url + _searchController.text.trim() , 
    headers: {"Authorization": "Token " + _token}) ; 
     // print(response.body);

  var body = json.decode(response.body) ; 
  _streamController.add(body);
  //  print(_streamController);
  }
  
  @override
  void initState() {
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dictionary"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10.0 , 
                    bottom: 8.0 , 
                    top: 1.0
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white , 
                    borderRadius: BorderRadius.circular(24.0)
                  ),
                  child: TextFormField(
                    
                    controller: _searchController,
                    decoration: InputDecoration(
                    hintText: "Search for a word" , 
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(13.0)
                    
                    ),
                  ),
                ),
                

              ) , 
              IconButton(
                onPressed: (){
                   _search();
                },
                icon: Icon(Icons.search , color: Colors.white,),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext ctx  , AsyncSnapshot snapshot){
          if(snapshot.data ==null){
            return Center(child:Text("Please enter a word to be search"));
          }
          var data = snapshot.data['definitions'] ; 
          var word = snapshot.data['word'];

          // print(data);
          

          return ListView.builder(
            itemCount: snapshot.data["definitions"].length,
            itemBuilder: (BuildContext ctx , int index){
              var type = data[index]['type'] ; 
              var _imageurl = data[index]['image_url'];
              var defination  =data[index]['definition'];
               print(_imageurl);
              return ListBody(children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.white70,
                  child: ListTile(

                    leading: _imageurl==null ?null :CircleAvatar(
                      backgroundImage: NetworkImage(_imageurl),
                    ) , 
                    title: Text(word + ' ($type)'),
                    subtitle: Text(defination),
                  
                  ),
                )
              ],);
            }) ; 
        },
      ),
    );
  }
}