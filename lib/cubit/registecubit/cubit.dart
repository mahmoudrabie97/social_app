import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/registecubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/usermodel.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uid: value.user!.uid,
      );

      //emit(RegisterSucessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uid}) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        isemaiverifie: false,
        image:
            'https://image.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg',
        bio: 'Write your Bio......',
        cover:
            'https://image.freepik.com/free-photo/pensive-handsome-young-bearded-man-blank-t-shirt-touching-his-chin-looks-aside-with-thoughtful-facial-expression_295783-14765.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSucessfulState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
