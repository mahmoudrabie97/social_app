import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/constants.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:socialapp/screens/newposts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Sociacubit, SocialStaes>(
      listener: (BuildContext context, state) {
        if (state is SocialNewPostState) {
          navigationto(context, NewPostsScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              Sociacubit.get(context)
                  .titles[Sociacubit.get(context).currentindex],
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notification_important)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 5,
          ),
          body: Sociacubit.get(context)
              .screens[Sociacubit.get(context).currentindex],
          bottomNavigationBar: BottomNavyBar(
              animationDuration: const Duration(microseconds: 1000),
              selectedIndex: Sociacubit.get(context).currentindex,
              itemCornerRadius: 32,
              // backgroundColor: kPrimaryLightColor,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text('Home'),
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: const Icon(Icons.chat),
                  title: Text('Chat'),
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.post_add),
                  title: Text('post'),
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                // BottomNavyBarItem(
                //   icon: const Icon(Icons.location_history_outlined),
                //   title: Text('Map'),
                //   activeColor: kPrimaryColor,
                //   inactiveColor: Colors.grey,
                //   textAlign: TextAlign.center,
                // ),
                BottomNavyBarItem(
                  icon: const Icon(Icons.settings),
                  title: const Text('Setting'),
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              ],
              onItemSelected: (index) {
                Sociacubit.get(context).changeNavBar(index);
              }),
        );
      },
    );
  }
}
