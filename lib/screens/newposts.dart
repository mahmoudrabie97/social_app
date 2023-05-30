import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/components.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';

class NewPostsScreen extends StatelessWidget {
  NewPostsScreen({Key? key}) : super(key: key);
  var textcontroller = TextEditingController();
  var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<Sociacubit, SocialStaes>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar:
              defaultAppbar(context: context, title: 'Creat Post', actions: [
            TextButton(
                onPressed: () {
                  if (Sociacubit.get(context).postImage == null) {
                    Sociacubit.get(context).createPost(
                        datetime: now.toString(), text: textcontroller.text);
                  } else {
                    Sociacubit.get(context).uploadPostimage(
                        datetime: now.toString(), text: textcontroller.text);
                  }
                },
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 18),
                )),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialloadingCreatePostState)
                  const LinearProgressIndicator(),
                if (state is SocialloadingCreatePostState)
                  const SizedBox(
                    height: 10,
                  ),
                ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration:
                        const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 6),
                    ]),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(
                              '${Sociacubit.get(context).model!.image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        '${Sociacubit.get(context).model!.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.check_circle, color: Colors.blue),
                    ],
                  ),
                  subtitle: Text('19 oct ,at 9pm'),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                        hintText: 'What is your mind..... ',
                        border: InputBorder.none),
                  ),
                ),
                if (Sociacubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: size.height * .25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 5),
                                  blurRadius: 8)
                            ],
                            image: DecorationImage(
                              image:
                                  FileImage(Sociacubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: IconButton(
                            onPressed: () {
                              Sociacubit.get(context).removeimagepot();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                            )),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Sociacubit.get(context).getpostImage();
                                },
                                icon: const Icon(Icons.image),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Add Photo')
                            ],
                          )),
                    ),
                    Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text('#tags')))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
