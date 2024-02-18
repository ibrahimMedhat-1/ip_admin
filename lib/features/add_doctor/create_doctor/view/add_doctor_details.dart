import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_admin/features/add_doctor/create_doctor/manager/create_doctor_cubit.dart';

class AddDoctorData extends StatelessWidget {
  const AddDoctorData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateDoctorCubit, CreateDoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        final CreateDoctorCubit cubit = CreateDoctorCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      cubit.changeImage(context);
                    },
                    child: const CircleAvatar(
                      radius: 80,
                      child: Align(alignment: Alignment.bottomRight, child: Icon(Icons.edit)),
                    ),
                  ),
                  TextFormField(
                    controller: cubit.nameController,
                    decoration: const InputDecoration(label: Text('Name')),
                  ),
                  TextFormField(
                    controller: cubit.addressController,
                    decoration: const InputDecoration(label: Text('Address')),
                  ),
                  TextFormField(
                    controller: cubit.phoneNoController,
                    decoration: const InputDecoration(label: Text('Phone')),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        cubit.addDoctorData(context);
                      },
                      child: const Text('Create Doctor'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
