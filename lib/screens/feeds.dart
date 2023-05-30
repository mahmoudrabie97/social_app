import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialapp/constants.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/screens/commentscreen.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);
  var commenntcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<Sociacubit, SocialStaes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Sociacubit.get(context).posts.isNotEmpty
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: const NetworkImage(
                                'https://image.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg'),
                            fit: BoxFit.cover,
                            height: size.height * .3,
                            width: double.infinity,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'communicate With Friends',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Sociacubit.get(context).posts.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return buildPostItems(
                          Sociacubit.get(context).posts[index],
                          context,
                          index,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget buildPostItems(
  PostModel model,
  BuildContext context,
  int index,
) {
  Size size = MediaQuery.of(context).size;

  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: bgStoryColors)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.3),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: bgWhite),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    '${model.image}',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text('${model.datetime}',
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 15,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${model.text}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, height: 1.4),
            ),
          ),
          if (model.postimage != '')
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${model.postimage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            Sociacubit.get(context).likePosts(
                                Sociacubit.get(context).postsId[index]);
                          },
                          icon: SvgPicture.asset(
                            'icons/heart.svg',
                            width: 20,
                            height: 20,
                          )),
                      Row(
                        children: [
                          Text('${Sociacubit.get(context).likes[index]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('likes',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showmodelbottomsheet(
                        context, Sociacubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      IconButton(
                          splashRadius: 15,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'icons/comment.svg',
                            width: 20,
                            height: 20,
                          )),
                      Row(
                        children: [
                          const Text(
                            'comments',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: (size.width - 30) * 0.7,
                child: Row(
                  children: [
                    Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: bgGrey),
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${Sociacubit.get(context).model!.image}'),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                        child: Container(
                      height: 25,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: TextField(
                          controller: commentcontroller,
                          cursorColor: textBlack.withOpacity(.5),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'add comment',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: textBlack.withOpacity(.5))),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Sociacubit.get(context).commentposts(
                      postId: Sociacubit.get(context).postsId[index],
                      datetime: Timestamp.now().toString(),
                      text: commentcontroller.text);
                },
                icon: Icon(Icons.send),
                color: kPrimaryColor,
              ),
            ],
          )
        ],
      ),
    ],
  );
}

/* 


 Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.black45, offset: Offset(0, 2), blurRadius: 6),
              ]),
              child: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    height: 50,
                    width: 50,
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  '${model.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.check_circle, color: Colors.blue),
              ],
            ),
            subtitle: Text('${model.datetime}'),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontSize: 18, height: 1.4),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: SizedBox(
                    height: 25,
                    // child: MaterialButton(
                    //     minWidth: 1.0,
                    //     padding: EdgeInsets.zero,
                    //     onPressed: () {},
                    //     child: Text('#SoFtware',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //           color: Colors.blue,
                    //         ))),
                  ),
                ),
              ],
            ),
          ),
          if (model.postimage != '')
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Container(
                height: size.height * .35,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8)
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model.postimage}',
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          //color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    iconSize: 20,
                  ),
                  Text('0',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.chat),
                    iconSize: 20,
                  ),
                  Text('0 Comments',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
      const Divider(
        thickness: 1,
      ),
      ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 2), blurRadius: 6),
          ]),
          child: CircleAvatar(
            child: ClipOval(
              child: Image(
                height: 50,
                width: 50,
                image: NetworkImage('${Sociacubit.get(context).model!.image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: const Text('Write a comment',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        trailing: IconButton(
            onPressed: () {}, icon: const Icon(Icons.favorite_border)),
      ),
    ],
  );

*/







 //سيبك من ده 

/* 

 Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3hlNuFGYw0dkcV1vUyNsDXQhZ-nKWA9wIpQ&usqp=CAU'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mahmoud Rabea',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 17,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_horiz))
                            ],
                          ),
                          Text(
                            'january 2021,at 9 pm',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
*/