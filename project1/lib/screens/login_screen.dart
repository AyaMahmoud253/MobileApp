import 'package:flutter/material.dart';
import 'package:project1/widgets/custom_text_field.dart';
import 'package:project1/widgets/custum_button.dart';
import 'package:project1/DatabaseHelper.dart'; // Import your DatabaseHelper class
import 'package:project1/screens/profile_screen.dart'; // Import the ProfilePage

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    // Retrieve email and password from text controllers
    String email = emailController.text;
    String password = passwordController.text;

    // Query the database to check if the credentials are valid
    DatabaseHelper dbHelper = DatabaseHelper();
    bool isValidUser = await dbHelper.authenticateUser(email, password);

    if (isValidUser) {
      // Navigate to the profile page if the user is authenticated
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userEmail: email),
        ),
      );
    } else {
      // Show an error message if the credentials are invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CustomTextField(
            obsText: false,
            controllerText: emailController,
            hint: 'Enter your email',
            label: 'Email',
            icon: Icon(Icons.email),
          ),
          SizedBox(height: 10),
          CustomTextField(
            obsText: true,
            controllerText: passwordController,
            hint: 'Enter your password',
            label: 'Password',
            icon: Icon(Icons.password),
          ),
          SizedBox(height: 15),
          CustomButton(
            text: 'Login',
            onPressed: () {
              login(context);
            },
          ),
        ],
      ),
    );
  }
}
