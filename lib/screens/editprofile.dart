import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/socialapp/cubit.dart';
import 'package:socialapp/cubit/socialapp/states.dart';
import 'package:socialapp/widgets/reusable_text_formfield.dart';
import 'package:socialapp/widgets/reusableboutton.dart';
import '../components.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return BlocConsumer<Sociacubit, SocialStaes>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            var usermodel = Sociacubit.get(context).model;
            var profileimage = Sociacubit.get(context).profileimage;
            var coverImage = Sociacubit.get(context).coverImage;

            namecontroller.text = usermodel!.name!;
            biocontroller.text = usermodel.bio!;
            phonecontroller.text = usermodel.phone!;

            Size size = MediaQuery.of(context).size;
            return Scaffold(
              appBar: defaultAppbar(
                  context: context,
                  title: 'Edit Profile',
                  actions: [
                    TextButton(
                        onPressed: () {
                          Sociacubit.get(context).updateUser(
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                              bio: biocontroller.text);
                        },
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      width: 15,
                    )
                  ]),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is SocialloadingupdateState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: size.height * .31,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: size.height * .25,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black45,
                                              offset: Offset(0, 5),
                                              blurRadius: 8)
                                        ],
                                        image: DecorationImage(
                                          image: coverImage != null
                                              ? FileImage(coverImage)
                                                  as ImageProvider
                                              : NetworkImage(
                                                  '${usermodel.cover}'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          Sociacubit.get(context)
                                              .getcoverImage();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black45,
                                            offset: Offset(0, 2),
                                            blurRadius: 6),
                                      ]),
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: Image(
                                        height: 120,
                                        width: 120,
                                        image: profileimage != null
                                            ? FileImage(
                                                profileimage,
                                              ) as ImageProvider
                                            : NetworkImage(
                                                '${usermodel.image}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                    radius: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          Sociacubit.get(context)
                                              .getprofileImage();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                        ))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (Sociacubit.get(context).profileimage != null ||
                          Sociacubit.get(context).coverImage != null)
                        Row(
                          children: [
                            if (Sociacubit.get(context).profileimage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    ReusableBoutton(
                                      text: 'Upload Profile',
                                      press: () {
                                        Sociacubit.get(context)
                                            .uploadProfileImage(
                                                name: namecontroller.text,
                                                phone: phonecontroller.text,
                                                bio: biocontroller.text);
                                      },
                                      width: size.width * .8,
                                    ),
                                    const SizedBox(height: 5),
                                    if (state is SocialloadingupdateState)
                                      const LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (Sociacubit.get(context).coverImage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    ReusableBoutton(
                                      text: 'Upload Cover',
                                      press: () {
                                        Sociacubit.get(context)
                                            .uploadcoverImage(
                                                name: namecontroller.text,
                                                phone: phonecontroller.text,
                                                bio: biocontroller.text);
                                      },
                                      width: size.width * .8,
                                    ),
                                    const SizedBox(height: 5),
                                    //if (state is SocialloadingupdateState)
                                    //const LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      TextformfieldContainer(
                          child: Resubletextformfield(
                              hinttex: 'name',
                              icon: Icons.person,
                              onchanged: (text) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'name must not empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false,
                              controller: namecontroller)),
                      const SizedBox(
                        height: 5,
                      ),
                      TextformfieldContainer(
                          child: Resubletextformfield(
                              hinttex: 'Bio',
                              icon: Icons.info_outline_rounded,
                              onchanged: (text) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'bio must not empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false,
                              controller: biocontroller)),
                      const SizedBox(
                        height: 5,
                      ),
                      TextformfieldContainer(
                          child: Resubletextformfield(
                              hinttex: 'Pjone',
                              icon: Icons.phone,
                              onchanged: (text) {},
                              onvalidate: (text) {
                                if (text!.isEmpty) {
                                  return 'mobilenumber must not empty';
                                } else {
                                  return null;
                                }
                              },
                              securetext: false,
                              controller: phonecontroller)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
