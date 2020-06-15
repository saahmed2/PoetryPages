import 'package:firebase_database/firebase_database.dart';
import 'package:poetry_pages/models/post.dart';

class PostService {
  String nodeName = "post";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;
  final Map post;

  PostService(this.post);

  addPost() {
    // Firebase database query referencing from the posts
    database.reference().child(nodeName).push().set(post);

  }

  deletePost() {
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost() {
    database.reference().child('$nodeName/${post['key']}').update(post);
  }
}