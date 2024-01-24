import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/cubit/authentication_cubit.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/views/widgets/add_user_dialog.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/views/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void createUser() {}
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const Center(
                  child: LoadingColumnWidget(message: "Fetching Users"),
                )
              : state is CreatingUser
                  ? const Center(
                      child: LoadingColumnWidget(message: "Creating User"),
                    )
                  : state is UserLoaded
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];

                              return ListTile(
                                leading: Image.network(user.avatar),
                                title: Text(user.name),
                                subtitle: Text(user.createdAt.substring(10)),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text("error brehh"),
                        ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) =>
                    AddUserDialogWidget(nameController: nameController),
              );
            },
            label: const Text("Add User"),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
