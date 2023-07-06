import 'package:bloc_test/data/api_provider.dart';
import 'package:flutter/material.dart';

class PostUserScreen extends StatefulWidget {
  static PageRouteBuilder getRoute() {
    return PageRouteBuilder(
      transitionsBuilder: (_, animation, secondAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (_, __, ___) {
        return const PostUserScreen();
      },
    );
  }

  const PostUserScreen({Key? key}) : super(key: key);

  @override
  _PostUserScreenState createState() => _PostUserScreenState();
}

class _PostUserScreenState extends State<PostUserScreen> {
  TextEditingController nameController = TextEditingController(text: "Dmitrii");
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "male");

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new user'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                filled: true,
                hintText: 'Enter your Name',
                labelText: 'Name ',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                filled: true,
                hintText: 'Enter your Email',
                labelText: 'Email ',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                icon: Icon(Icons.group),
                filled: true,
                hintText: 'Enter your Gender',
                labelText: 'Gender ',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  ApiProvider().postUser(
                    context: context,
                    name: nameController.text,
                    email: emailController.text,
                    gender: genderController.text,
                  );
                },
                child: Text("Add User".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
