import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/constants.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/models/messgemodel.dart';
import 'package:socialapp/models/usermodel.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;
  var messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        Sociacubit.get(context).getmessages(reciverid: userModel!.uid!);
        return BlocConsumer<Sociacubit, SocialStaes>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                titleSpacing: 0.0,
                elevation: 0,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${userModel!.name}',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: Sociacubit.get(context).messages.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var message = Sociacubit.get(context).messages[index];
                          if (Sociacubit.get(context).model!.uid ==
                              message.senderId) {
                            return widgetbuildmymessage(message);
                          }
                          return widgetbuildmessage(message);
                        },
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: messagecontroller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your Messege here....',
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: blueColor,
                            child: MaterialButton(
                              onPressed: () {
                                Sociacubit.get(context).sendMessages(
                                    recivedId: userModel!.uid,
                                    datetime: DateTime.now().toString(),
                                    text: messagecontroller.text);
                              },
                              minWidth: 1.0,
                              height: 50,
                              child: Icon(
                                Icons.send_outlined,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget widgetbuildmymessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        decoration: BoxDecoration(
          color: blueColor.withOpacity(.3),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        child: Text(
          '${model.text}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget widgetbuildmessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(.4),
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        child: Text(
          '${model.text}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
