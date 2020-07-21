import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("MemeBahadur"),
            centerTitle: true,
            
            backgroundColor: Colors.grey,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(leading: Icon(Icons.menu), trailing: Text('Enter Your Search Query Here'),),
             
            ]),
          )
        ],

      ),
    



      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
      floatingActionButton: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
     children: [
         ClipOval(  child:Container(width: 80,height: 80 ,color: Colors.red[300], 
                  child: IconButton(onPressed: () {} ,
                  icon: Icon(Icons.camera),),) ),
          ClipOval(  child:Container(width: 80, height: 80, color: Colors.red[300],
                 child: IconButton(onPressed: (){} ,
                 icon: Icon(Icons.photo_library),),) ),
          ClipOval(  child:Container(width: 80, height: 80, color: Colors.red[300], 
                  child: IconButton(onPressed: ()=> Navigator.of(context).pushNamed('/templates') ,
                    icon: Icon(Icons.cloud_download),),) ),
    
  ]
),
















    );
  }
}