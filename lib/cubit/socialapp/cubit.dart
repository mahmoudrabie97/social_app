import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/constants.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/models/comment.dart';
import 'package:socialapp/models/messgemodel.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/screens/chats.dart';
import 'package:socialapp/screens/feeds.dart';
import 'package:socialapp/screens/newposts.dart';
import 'package:socialapp/screens/settings.dart';
import 'package:socialapp/screens/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Sociacubit extends Cubit<SocialStaes> {
  Sociacubit() : super(SocialInitialState());
  static Sociacubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostsScreen(),
    //const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats ⚡️',
    'News Posts',
    //'Users',
    'Settings',
  ];

  int currentindex = 0;
  void changeNavBar(int index) {
    if (index == 1) {
      getusers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentindex = index;
      emit(SocialChangeNavBarState());
    }
  }

  File? profileimage;
  var picker = ImagePicker();
  Future<void> getprofileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      emit(SocialSucsessProfileimageState());
    } else {
      print('NoImage');
      emit(SocialerrorProfileimageState());
    }
  }

  File? coverImage;

  Future<void> getcoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialSucsessCoverimageState());
    } else {
      print('NoImage');
      emit(SocialerrorCoverimageState());
    }
  }

  void uploadProfileImage(
      {required String name, required String phone, required String bio}) {
    emit(SocialloadingupdateState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
        //emit(SocialSucsessuploadProfileimageState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialerroruploadProfileimageState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialerroruploadProfileimageState());
    });
  }

  void uploadcoverImage(
      {required String name, required String phone, required String bio}) {
    emit(SocialloadingupdateState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        //emit(SocialSucsessuploadCoverimageState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialerroruploadCoverimageState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialerroruploadCoverimageState());
    });
  }

  // void updateuserimages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialloadingupdateState());
  //   if (coverImage != null) {
  //     uploadcoverImage();
  //   } else if (profileimage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileimage != null) {
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel modelupdate = UserModel(
      name: name,
      phone: phone,
      isemaiverifie: false,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      uid: model!.uid,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(modelupdate.uid)
        .update(modelupdate.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialerrorupdateState());
    });
  }

  File? postImage;

  Future<void> getpostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialSucsesspostimageState());
    } else {
      print('NoImage');
      emit(SocialerrorspostimageState());
    }
  }

  void uploadPostimage({
    required String datetime,
    required String text,
  }) {
    emit(SocialloadingCreatePostState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(datetime: datetime, text: text, postimage: value);
        //emit(SocialSucsessuploadCoverimageState());
      }).catchError((error) {
        print(error.toString());
        emit(SociallErrorCreatposteState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SociallErrorCreatposteState());
    });
  }

  void createPost({
    required String datetime,
    required String text,
    String? postimage,
  }) {
    emit(SocialloadingCreatePostState());
    PostModel modelpost = PostModel(
        name: model!.name,
        image: model!.image,
        uid: model!.uid,
        datetime: datetime,
        text: text,
        postimage: postimage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(modelpost.toMap())
        .then((value) {
      emit(SociallSuccessCreatposteState());
    }).catchError((error) {
      emit(SociallErrorCreatposteState());
    });
  }

  void removeimagepot() {
    postImage = null;
    emit(SocialremovepostimageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datetime', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      likes = [];
      postsId = [];
      emit(SocialGetPostSucsessState());
      event.docs.forEach((element) async {
        await element.reference.collection('Likes').get().then((value) {
          emit(SocialGetPostSucsessState());
          posts.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
          likes.add(value.docs.length);
        }).catchError((error) {
          print(error.toString());
        });
      });
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(model!.uid)
        .set({'like': true}).then((value) {
      emit(SocialGetLikePostssSucsessState());
    }).catchError((error) {
      emit(SocialGetLikePostsErrorState(error));
    });
  }

  void commentposts({
    required String postId,
    required String datetime, // filedvalue.servertimestamp
    required String text,
    //String? commentimage,
  }) {
    CommentModel commentModel = CommentModel(
      name: model!.name,
      //commentimage: commentimage,
      text: text,
      uid: model!.uid,
      datetime: datetime,
      image: model!.image,
    );
    emit(SocialLoadingCommentState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Comments')
        .doc(model!.uid)
        .set(commentModel.toMap())
        .then((value) {
      emit(SocialeSuccessCommentState());
    }).catchError((error) {
      emit(SocialErrorCommentState());
    });

    // void addlike({
    //   BuildContext? context,
    //   String? postId,
    // }) {
    //   FirebaseFirestore.instance
    //       .collection('posts')
    //       .doc(postId)
    //       .collection('likes')
    //       .doc(model!.uid)
    //       .set({
    //     'likes': FieldValue.increment(1),
    //     'username': model!.name,
    //     'useruid': model!.uid,
    //     'userimage':model!.image,
    //     'useremail':model!.email,
    //     'time':Timestamp.now(),
    //   }).then((value)
    //   {
    //      emit(SocialGetLikePostssSucsessState());
    //   }).catchError((error)
    //   {
    //   emit(SocialGetLikePostsErrorState(error));
    //   });
    // }
  }

  List<CommentModel> postcomments = [];
  void getpostcomments(
    String postid,
  ) {
    postcomments = [];
    emit(SocialLoadingGetCommentState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('Comments')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        postcomments.add(CommentModel.fromJson(element.data()));
      });
      emit(SocialeSuccessGetCommentState());
    });
  }

  List<UserModel> users = [];
  void getusers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model!.uid) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSucsessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorState());
      });
    }
  }

  void sendMessages(
      {required recivedId, required String datetime, required String text}) {
    MessageModel messageModel = MessageModel(
      senderId: model!.uid,
      reciverId: recivedId,
      datetime: datetime,
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(recivedId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialeSuccessSendMeeagesState());
    }).catchError((error) {
      emit(SocialErrorSendMeeagesState());
    });
// set reciver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(recivedId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialeSuccessSendMeeagesState());
    }).catchError((error) {
      emit(SocialErrorSendMeeagesState());
    });
  }

  List<MessageModel> messages = [];

  void getmessages({required String reciverid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(reciverid)
        .collection('messages')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialeSuccessGetSendMeeagesState());
    });
  }
}
