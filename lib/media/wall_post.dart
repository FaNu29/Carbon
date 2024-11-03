import 'package:carbon/Style/comment.dart';
import 'package:carbon/Style/comment_button.dart';
import 'package:carbon/Style/delete_button.dart';
import 'package:carbon/Style/leaf_button.dart';
import 'package:carbon/helper/helper_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.user,
    required this.message,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  int commentCount=0;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Comment"),
              content: TextField(
                controller: _commentTextController,
                decoration: InputDecoration(
                  hintText: "Add Comment",
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commentTextController.clear();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      addComment(_commentTextController.text.trim());
                      _commentTextController.clear();
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

  Future<int> getCommentCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments").get();
    return querySnapshot.size;
  }

  Future<void> fetchCommentCount() async {
    int count = await getCommentCount();
    setState(() {
      commentCount = count; // Update the state with the fetched count
    });
  }

  //delete a post
  void deletePost(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete Post"),
          content: const Text(" Are you sure you want to delete this post?"),
          actions: [
            //cancel button
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel",style: TextStyle(color: Colors.grey),)),
            // delete button
            TextButton(
                onPressed: () async {
                  // delete comment from firebase
                  final commentDocs = await FirebaseFirestore.instance
                      .collection("User Posts")
                      .doc(widget.postId)
                      .collection("Comments")
                      .get();
                 for (var doc in commentDocs.docs){
                   await FirebaseFirestore.instance
                       .collection("User Posts")
                       .doc(widget.postId)
                       .collection("Comments")
                       .doc(doc.id)
                       .delete();
                 }
                  //delete the post
                 try {
                   FirebaseFirestore.instance.collection("User Posts")
                       .doc(widget.postId).delete();
                 } on Exception catch (e) {
                   print(e);
                 }

                 Navigator.pop(context);

                },
                child: const Text("Delete",style: TextStyle(color: Color(0xFF455932)),))

          ],
        ));
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
          border:
              Border.all(style: BorderStyle.solid, color: Color(0xFF455932))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // message and user name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(widget.user,
                        style: TextStyle(
                            color: Colors.grey[600]
                        ),
                      ),
                      Text(".,",
                        style: TextStyle(
                            color: Colors.grey[600]
                        ),),
                      Text(widget.time,
                        style: TextStyle(
                            color: Colors.grey[600]
                        ),
                      )
                    ],
                  )
                ],
              ),

              // delete button
              if(widget.user == currentUser.email)
                DeleteButton(onTap: deletePost,)



            ],
          ),
          SizedBox(
            height: 7,
          ),
          //Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Leaf button
              Column(
                children: [
                  LeafButton(isLiked: isLiked, onTap: toggleLike),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.likes.length.toString()),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              //Comment button
              Column(
                children: [
                  CommentButton(onTap: showCommentDialog),
                  SizedBox(
                    height: 5,
                  ),
                  Text(commentCount.toString())
                ],
              ),
            ],
          ),

         SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  //get the comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  //return the comment
                  return Comment(
                      text: commentData["CommentText"],
                      user: commentData["CommentedBy"],
                      time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
