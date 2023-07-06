import 'package:bloc_test/bloc/api_bloc.dart';
import 'package:bloc_test/bloc/api_event.dart';
import 'package:bloc_test/bloc/api_state.dart';
import 'package:bloc_test/data/api_provider.dart';
import 'package:bloc_test/data/user.dart';
import 'package:bloc_test/ui/post_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocPage extends StatefulWidget {
  const MyBlocPage({Key? key}) : super(key: key);

  @override
  State<MyBlocPage> createState() => _MyBlocPageState();
}

class _MyBlocPageState extends State<MyBlocPage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PostUserScreen.getRoute());
        },
        child: const Icon(Icons.person_add),
      ),
      body: buildBloc(),
    );
  }

  /**  --------------- Focus Here  ----------------------- **/
  Widget buildBloc() {
    return BlocBuilder<ApiBloc, ApiState>(builder: (context, state) {
      if (state is InitialState) {
        return buildInitialView();
      }
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is SuccessUserList) {
        List<User> user = state.usersList;
        return buildUserList(user);
      }
      if (state is FailureState) {
        return const Text('Error while Connecting');
      }
      return const Text('Nothing');
    });
  }

  Center buildInitialView() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // call bloc and send event
          context.read<ApiBloc>().add(GetUsersEvent());
        },
        child: Text(
          'Get Users'.toUpperCase(),
        ),
      ),
    );
  }
  /**
      --------------- Focus Here  -----------------------
   **/

  Widget buildUserList(List<User> users) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 2),
          () {},
        );
      },
      child: RefreshIndicator(
        onRefresh: () async {
          users = [];
          await ApiProvider().getUsers();
          return Future.value(true);
        },
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(users[index].gender == "female"
                        ? Icons.female
                        : Icons.male),
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                    trailing: users[index].status == "active"
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(Icons.cancel, color: Colors.red),
                  ),
                  const Divider(),
                ],
              );
            }),
      ),
    );
  }
}
