import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rana_academy/providers/user_provider.dart';
import 'package:rana_academy/resources/firestore_methods.dart';
import 'package:rana_academy/utils/colors.dart';
import 'package:rana_academy/utils/utils.dart';
import '../widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  bool _isLoading = false;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final instaUser = Provider.of<UserProvider>(context).getInstaUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('publishDate', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => CommentCard(
                snap: snapshots.data!.docs[index],
              ),
              itemCount: snapshots.data!.docs.length,
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.snap['profileImage']),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Comment as ${widget.snap['userName']}',
                      border: InputBorder.none,
                    ),
                    controller: _commentController,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.send),
              // ),

              InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_commentController.text.isEmpty) {
                    showSnackBar('Please fill the text', context);
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    String res = await FirestoreMethods().postComment(
                        widget.snap['postId'],
                        _commentController.text,
                        instaUser.uid,
                        instaUser.userName,
                        instaUser.imageUrl);
                    // ignore: use_build_context_synchronously
                    showSnackBar(res, context);
                    setState(() {
                      _isLoading = false;
                    });
                    if (res == 'Posted') _commentController.clear();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
