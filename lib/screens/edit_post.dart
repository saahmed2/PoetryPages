import 'package:flutter/material.dart';
import 'package:poetry_pages/db/PostService.dart';
import 'package:poetry_pages/models/post.dart';

import 'home.dart';

class EditPost extends StatefulWidget {
  final Post post;

  const EditPost(this.post);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
    final GlobalKey<FormState> formkey = new GlobalKey();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
          elevation: 0.0,
        ),
        body: Form(
            key: formkey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.post.title,
                      decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder()
                      ),
                      onSaved: (val) => widget.post.title = val,
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
                    initialValue: widget.post.body,
                      decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder()
                      ),
                      onSaved: (val) => widget.post.body = val,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          //Navigator.pop(context);
        },
          child: Icon(Icons.edit, color: Colors.white,),
          backgroundColor: Colors.orange,
          tooltip: "Exit a Note",),
      );
    }

    void insertPost() {
      final FormState form = formkey.currentState;
      //if the form is valid, save the current state
      if (form.validate()) {
        form.save();
        form.reset();
        //takes the current date of the device
        widget.post.date = DateTime
            .now()
            .millisecondsSinceEpoch;
        PostService postService = PostService(widget.post.toMap());
        postService.updatePost();
      }
    }
  }
