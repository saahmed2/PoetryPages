import 'package:flutter/material.dart';
import 'package:poetry_pages/db/PostService.dart';
import 'package:poetry_pages/models/post.dart';

import 'home.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post = Post(0, " ", " ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Note"),
        elevation: 0.0,
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder()
                    ),
                    onSaved: (val) => post.title = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "title field cannot be empty";
                      } else if (val.length > 16) {
                        return "Title cannot have more than 16 characters ";
                      }
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 10,
                    maxLines: 15,
                    decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder()
                    ),
                    onSaved: (val) => post.body = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "description field cannot be empty";
                      }
                    }
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        insertPost();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pop(context);
      },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.orange,
        tooltip: "Add a Note",),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    //if the form is valid, save the current state
    if (form.validate()) {
      form.save();
      form.reset();
      //takes the current date of the device
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      postService.addPost();

    }
  }

}

