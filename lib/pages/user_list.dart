import 'package:flutter/material.dart';
import 'package:location_service/Services/user_list_service.dart';


//This will hold user list
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
 UserListService _userListService ; 
  @override
  Widget build(BuildContext context) {
  _userListService = new UserListService();

    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: FutureBuilder(future: _userListService.getUser(),
        builder: (BuildContext ctx , AsyncSnapshot snapshot){
         if(snapshot.data==null){
           return Center(child: CircularProgressIndicator(),);
         }else{
           print(snapshot.data);
            //  return Text(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext ctx , int index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data[index].image
                    ),
                  ),
                  title: Text(snapshot.data[index].name),
                  subtitle: Text(snapshot.data[index].phone),
                ) ; 
            });
         }
        },
      ),

    );
  }
}