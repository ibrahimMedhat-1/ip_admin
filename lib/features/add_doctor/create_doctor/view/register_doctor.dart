import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_admin/features/add_doctor/create_doctor/manager/create_doctor_cubit.dart';

class RegisterDoctor extends StatelessWidget {
  const RegisterDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateDoctorCubit, CreateDoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        final CreateDoctorCubit cubit = CreateDoctorCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Add Doctor')),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: cubit.emailController,
                  decoration: const InputDecoration(
                    label: Text('Doctor Email'),
                  ),
                ),
                TextFormField(
                  controller: cubit.passwordController,
                  decoration: const InputDecoration(
                    label: Text('Doctor Password'),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    cubit.registerDoctor(context);
                  },
                  child: const Text('Register Doctor'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
