import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_admin/features/add_pharmacy/create_new_pharmacy/manager/create_pharmacy_cubit.dart';

class AddPharmacyDetails extends StatelessWidget {
  const AddPharmacyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePharmacyCubit, CreatePharmacyState>(
      listener: (context, state) {},
      builder: (context, state) {
        final CreatePharmacyCubit cubit = CreatePharmacyCubit.get(context);
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      cubit.getPharmacyImage();
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
                    controller: cubit.phoneController,
                    decoration: const InputDecoration(label: Text('Phone')),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        cubit.addPharmacyData(context);
                      },
                      child: const Text('Create Pharmacy'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
