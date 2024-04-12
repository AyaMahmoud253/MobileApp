import 'package:flutter/material.dart';
import 'package:project1/widgets/custom_text_field.dart';
import 'package:project1/widgets/custum_button.dart';
import 'package:project1/DatabaseHelper.dart'; // Import your DatabaseHelper class
import 'package:project1/screens/profile_screen.dart'; // Import the ProfilePage

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up Screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? selectedGender;
  String? selectedLevel;

  void registerUser(BuildContext context) async {
    // Validate input
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        !emailController.text.endsWith('@stud.fci-cu.edu.eg') ||
        !emailController.text.startsWith(RegExp(r'^[0-9]+')) ||
        idController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        passwordController.text.length < 8 ||
        confirmPasswordController.text != passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid input. Please check all fields.'),
        ),
      );
      return;
    }

    // Prepare user data
    Map<String, dynamic> userData = {
      'name': nameController.text,
      'gender':
          selectedGender ?? '', // Use selectedGender or empty string if null
      'email': emailController.text,
      'studentId': idController.text,
      'level': selectedLevel ?? '', // Use selectedLevel or empty string if null
      'password': passwordController.text,
    };

    // Insert user into SQLite database
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.insertUser(userData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration Successful.'),
      ),
    );

    // Navigate to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(userEmail: emailController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        CustomTextField(
          obsText: false,
          controllerText: nameController,
          hint: 'Type your name',
          icon: Icon(Icons.person),
          label: 'Name',
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text('Gender:'),
            SizedBox(width: 10),
            // Radio buttons for gender selection
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        CustomTextField(
          obsText: false,
          controllerText: emailController,
          hint: 'i.e, studentID@stud.fci-cu.edu.eg',
          label: 'Email',
          icon: Icon(Icons.email),
        ),
        SizedBox(height: 10),
        CustomTextField(
          obsText: false,
          controllerText: idController,
          hint: 'i.e, 20200001',
          icon: Icon(Icons.perm_identity),
          label: 'ID',
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedLevel,
          hint: Text('Select Level'), // Placeholder
          decoration: InputDecoration(
            labelText: 'Level',
            icon: Icon(Icons.numbers),
          ),
          onChanged: (newValue) {
            setState(() {
              selectedLevel = newValue;
            });
          },
          items: ['1', '2', '3', '4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        CustomTextField(
          obsText: true,
          controllerText: passwordController,
          hint: 'Password (at least 8 characters)',
          label: 'Password',
          icon: Icon(Icons.password),
        ),
        SizedBox(height: 10),
        CustomTextField(
          obsText: true,
          controllerText: confirmPasswordController,
          hint: 'Confirm Password',
          label: 'Confirm Password',
          icon: Icon(Icons.password),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already a member? ',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'LoginPage');
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        CustomButton(
          text: 'Submit',
          onPressed: () async {
            registerUser(context);
          },
        )
      ],
    );
  }
}
