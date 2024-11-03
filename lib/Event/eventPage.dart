import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Eventpage extends StatefulWidget {
  const Eventpage({super.key});

  @override
  State<Eventpage> createState() => _EventpageState();
}

class _EventpageState extends State<Eventpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF93A87F),
      appBar: AppBar(
        backgroundColor: Color(0xFF455932),
        elevation: 0,
        title: Text(
          'Upcoming Events',
          style: TextStyle(color: Colors.white),

        ),
      ),
      body:Center(
         child: Column(
           children: [
             Expanded(
                 child: StreamBuilder(
                   stream: FirebaseFirestore.instance
                       .collection("Events")
                       .orderBy("TimeStamp",descending: false).snapshots()
                   ,
                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       return ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index) {
                           final event = snapshot.data!.docs[index];
                         },

                       );
                     }
                     else if (snapshot.hasError) {
                       return Center(
                         child: Text("Error: ${snapshot.error}"),
                       );
                     }
                     return Center(child: const CircularProgressIndicator());

                   }
                 )
              )
           ],
         ),
      ),
    );
  }
}
