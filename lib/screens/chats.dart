import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/screens/chatsdetails.dart';

import '../constants.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Sociacubit, SocialStaes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: Sociacubit.get(context).users.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return widgetbuildchatitem(
                Sociacubit.get(context).users[index], context);
          },
        );
      },
    );
  }

  Widget widgetbuildchatitem(UserModel model, BuildContext context) {
    return InkWell(
      onTap: () {
        navigationto(
            context,
            ChatDetails(
              userModel: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
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
                          image: NetworkImage('${model.image}'),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
