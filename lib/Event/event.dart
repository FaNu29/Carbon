import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Event extends StatefulWidget {

  final String title;
  final String iD;
  final String time;
  final String date;
  final String user;
  final String place;
  final String description;
  final List<String> going;


  const Event({super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.user,
    required this.place,
    required this.description,
    required this.going,
    required this.iD});


  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();




  int goingCount=0;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isGoing = false;

  @override

  void initState() {
    super.initState();
    isGoing = widget.going.contains(currentUser.email);
  }

  void toggleGoing() {
    setState(() {
      isGoing = !isGoing;
    });
    DocumentReference postRef =
    FirebaseFirestore.instance.collection("Events").doc(widget.iD);

    if (isGoing) {
      postRef.update({
        "Going": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        "Going": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addEvent(String title, String time, String date, String place, String description ){
      FirebaseFirestore.instance
          .collection("Events")
          .add({
        "Title" : title,
        "Place" : place,
        "Date" : date,
        "Time" : time,
        "Description" :description,
        "User" : currentUser.email
      });
  }

  void showEventBox(){
    showDialog(context: context,
        builder: (context) => AlertDialog(
           title: Text('Add Event'),
          content:ListView(
            children: [

              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                   hintText: "Event Title"
                ),
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                    hintText: " When the event will take place"
                ),
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(
                    hintText: "Time of the Event"
                ),
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: placeController,
                decoration: InputDecoration(
                    hintText: "Where the event will take place"
                ),
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Description of the event"
                ),
              ),
              SizedBox(height: 5,),

            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  titleController.clear();
                  placeController.clear();
                  timeController.clear();
                  dateController.clear();
                  descriptionController.clear();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.bold),
                )),

            TextButton(
                onPressed: () {
                  addEvent(
                      titleController.text.trim(),
                      timeController.text.trim(),
                      dateController.text.trim(),
                      placeController.text.trim(),
                      descriptionController.text.trim()
                  );

                  titleController.clear();
                  placeController.clear();
                  timeController.clear();
                  dateController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Color(0xFF455932),
                      fontWeight: FontWeight.bold),
                )),

          ],
        ));
  }


  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
