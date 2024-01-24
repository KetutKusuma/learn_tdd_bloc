import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/cubit/authentication_cubit.dart';

class AddUserDialogWidget extends StatelessWidget {
  const AddUserDialogWidget({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
                controller: nameController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    const avatar = "https://cloudflare-ipfs.com/ipfs"
                        "/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/436.jpg";
                    context.read<AuthenticationCubit>().createUsers(
                          createdAt: DateTime.now().toString(),
                          name: name,
                          avatar: avatar,
                        );
                    nameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Create User"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
