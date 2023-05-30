import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/models/comment.dart';
import 'package:socialapp/models/usermodel.dart';

import '../constants.dart';

var commentcontroller = TextEditingController();
showmodelbottomsheet(BuildContext context, String postid) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Builder(
          builder: (BuildContext context) {
            Sociacubit.get(context).getpostcomments(postid);

            return BlocConsumer<Sociacubit, SocialStaes>(
              listener: (BuildContext context, state) {},
              builder: (BuildContext context, Object? state) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .75,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 150.0),
                          child: Divider(
                            thickness: 4,
                            color: whiteColor,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: whiteColor),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                              child: Text(
                            'Comments',
                            style: TextStyle(
                              color: blueColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              Sociacubit.get(context).postcomments.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 8,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return buildcomment(
                                context,
                                Sociacubit.get(context).model!,
                                Sociacubit.get(context).postcomments[index]);
                          },
                        ),
                        Divider(color: darkColor.withOpacity(.2)),
                        Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                width: 300,
                                height: 20.0,
                                child: TextField(
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  controller: commentcontroller,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    hintText: 'Add Comment.....',
                                    hintStyle: TextStyle(
                                      color: whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              FloatingActionButton(
                                backgroundColor: greenColor,
                                onPressed: () {},
                                child: Icon(
                                  Icons.send,
                                  color: whiteColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: blueGreyColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                    ),
                  ),
                );
              },
            );
          },
        );
      });
}

Widget buildcomment(
    BuildContext context, UserModel model, CommentModel commentmodel) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.11,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                  backgroundColor: darkColor,
                  radius: 15.0,
                  backgroundImage: NetworkImage('${model.image}')),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: const TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_upward,
                      color: blueColor,
                    )),
                const Text(
                  '0',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: redColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.reply,
                      color: yellowColor,
                    )),
              ],
            ))
          ],
        ),
        // شيل من هنا
        Expanded(
          child: Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: blueColor,
                      size: 12,
                    )),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      '${commentmodel.text}',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    ),
  );
}
