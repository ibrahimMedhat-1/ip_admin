import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ip_admin/features/add_doctor/create_doctor/view/add_doctor_details.dart';
import 'package:ip_admin/models/doctor_model.dart';

import '../../../../shared/custom_transitions/custom_transitions.dart';
import '../../../../shared/image_helper/image_helper.dart';
import '../../../../shared/utils/toasts.dart';

part 'create_doctor_state.dart';

class CreateDoctorCubit extends Cubit<CreateDoctorState> {
  CreateDoctorCubit() : super(CreateDoctorInitial());

  static CreateDoctorCubit get(context) => BlocProvider.of(context);
  String? doctorId;
  String? imageLink;
  File? imageFile;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController specialityController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  void registerDoctor(context) {
    emit(RegisterDoctorLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim())
        .then((value) {
      doctorId = value.user!.uid;
      FirebaseFirestore.instance
          .collection('doctors')
          .doc(value.user!.uid)
          .set(
            DoctorModel(
              value.user!.uid,
              '',
              '',
              {
                'longitude': '',
                'latitude': '',
                'text': '',
              },
              '',
              '',
              '',
              DateTime.now().toString(),
            ).toMap(),
          )
          .then((value) {
        emit(RegisterDoctorSuccessfully());
        Navigator.pushReplacement(
            context,
            NavigateSlideTransition(
              child: const AddDoctorData(),
            ));
      });
    }).catchError((onError) {
      emit(RegisterDoctorError());
      showToast(onError.message);
    });
  }

  void changeImage(context) async {
    final files = await ImageHelper().pickImage();
    if (files.isNotEmpty) {
      final croppedImage = await ImageHelper().crop(file: files.first!, cropStyle: CropStyle.circle);
      if (croppedImage != null) {
        imageFile = File(croppedImage.path);
      } else {
        imageFile = File(files.first!.path);
      }
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Change profile picture ?'),
              content: FittedBox(
                child: CircleAvatar(
                  radius: 80,
                  foregroundImage: FileImage(imageFile!),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () {
                    emit(ChangeProfilePicture());
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ));
  }

  void addDoctorData(context) async {
    emit(AddDoctorDataLoading());
    if (imageFile != null) {
      await FirebaseStorage.instance
          .ref()
          .child('doctors/$doctorId')
          .putFile(File(imageFile!.path))
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          imageLink = value;
        });
      });
    }
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorId)
        .set(DoctorModel(
          doctorId,
          nameController.text,
          phoneNoController.text,
          {
            'addressLongitude': '',
            'addressLatitude': '',
            'text': addressController.text,
          },
          specialityController.text,
          bioController.text,
          imageLink,
          DateTime.now().toString(),
        ).toMap())
        .then((value) {
      emit(AddDoctorDataSuccessfully());
      Navigator.pop(context);
    });
  }

  void clearTextFormFields() {
    emailController.clear();
    passwordController.clear();
    emit(ClearAllTextFormFields());
  }
}
