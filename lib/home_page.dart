import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memebahadur/general_model.dart';

import 'package:memebahadur/wavy_header.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }


  Widget _buildPopularList(context,index, List<Popular>listImages) {


    return
      Container(
        
        width: 200.0,
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(

                  listImages[index].image,
                  width: 220.0,
                  height: 100.0,

                  fit: BoxFit.cover,)),
            Text(listImages[index].name,style: TextStyle(color: Colors.grey),),
            Text(listImages[index].desc,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
            Text(listImages[index].price,style: TextStyle(fontSize: 12.0)),
            
          ],
        ),






      );
  }

  Widget _buildFruitCategoryList(context,index, List<FruitsCategory>listImages) {


    return
      Padding(
        
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(

                  listImages[index].image,
                  width: 180.0,
                  height: 90.0,

                  fit: BoxFit.cover,)),
            Text(listImages[index].name)
          ],
        ),






      );
  }



  Widget _buildHomeList(context,index, List<Homes>listImages) {


    return
      Padding(
        padding: const EdgeInsets.only(left:10.0,top: 10.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(

                  listImages[index].image,
                  width: 200.0,
                  height: 100.0,

                  fit: BoxFit.cover,)),
            Text(listImages[index].name)
          ],
        ),






      );
  }

  int _currentIndex=0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(

              children: <Widget>[
                WavyHeader(),
                Align(
                 alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top:100.0),
                    child: Container(
                      height: 50.0,

                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFCFCFC).withOpacity(0.3),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                     
                    ),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.only(top:40.0,left: 10.0,),
                 child: Align(
                     alignment: Alignment.topLeft,
                    child: Image.asset('assets/images/name.png',height: 40.0,color: Colors.white,)),
                    // child: Text("Nearby",style: TextStyle(fontSize: 40.0,color: Color(0xFFFCFCFC),fontWeight: FontWeight.bold),)),
               )



              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 10.0,),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Categories",style: TextStyle(fontSize: 30.0,color: Colors.black54,fontWeight: FontWeight.bold),)),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 120.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _buildFruitCategoryList(context,index,fruitsCategoryList.fruitsCategory);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 10.0,),
              child: Text("Most Popular",style: TextStyle(fontSize: 30.0,color: Colors.black54,fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 220.0,

              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildPopularList(context,index,fruitsCategoryList.popular);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 10.0,),
              child: Text("Homes",style: TextStyle(fontSize: 30.0,color: Colors.black54,fontWeight: FontWeight.bold),),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 150.0,

              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildHomeList(context,index,fruitsCategoryList.homes);
                  }),
            ),

          ],
        ),

      ),
        bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          elevation: 8.0,
          items:[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF3461eb),
            icon: Icon(Icons.home), title: Text('Home')),
          
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF5c7066),
            icon: Icon(Icons.save), title: Text('My Memes'))
          
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },),


        floatingActionButton: SpeedDial(
          foregroundColor: Color(0xFF5c7066),
          overlayColor: Color(0xFF5c7066),
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlueAccent,
          shape: CircleBorder(),
          children: [
           SpeedDialChild(
              child: Icon(Icons.camera),
              backgroundColor: Colors.red,
              label: 'Camera',
              labelStyle: TextStyle(fontSize: 18.0),

              
            ),
            SpeedDialChild(
              child: Icon(Icons.photo_library),
              backgroundColor: Colors.red,
              label: 'Gallery',
              onTap:() => {getImage},
              labelStyle: TextStyle(fontSize: 18.0),
              
            ),
            SpeedDialChild(
              child: Icon(Icons.cloud_download),
              backgroundColor: Colors.red,
              label: 'Template',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
            ),
          ],
        ),

    );
  }
}
