import 'package:flutter/material.dart';
import 'package:project1/DatabaseHelper.dart';
import 'package:project1/screens/profile_screen.dart';
import 'package:project1/widgets/custom_text_field.dart';
import 'package:project1/widgets/custum_button.dart';

class EditProfilePage extends StatefulWidget {
  final String userEmail;

  EditProfilePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  //initialized for managing text input fields
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
  }

  void saveChanges(BuildContext context) async {
    // Fetch the current user data
    Map<String, dynamic>? currentUserData =
        await dbHelper.getUserDataByEmail(widget.userEmail);

    if (currentUserData != null) {
      // Prepare the data to be updated
      Map<String, dynamic> updatedData = {
        'name': nameController.text.isNotEmpty
            ? nameController.text
            : currentUserData['name'],
        'gender': genderController.text.isNotEmpty
            ? genderController.text
            : currentUserData['gender'],
        'studentId': idController.text.isNotEmpty
            ? idController.text
            : currentUserData['studentId'],
        'level': levelController.text.isNotEmpty
            ? levelController.text
            : currentUserData['level'],
      };

      // Update user data by email
      await dbHelper.updateUserDataByEmail(
        email: widget.userEmail,
        data: updatedData,
      );

      // Navigate to ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userEmail: widget.userEmail),
        ),
      );
    } else {
      // Handle the case where user data couldn't be fetched
      // You might want to show an error message or handle it based on your app's logic
      print('User data not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit your profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          CustomTextField(
            obsText: false,
            controllerText: nameController,
            hint: 'Update your name',
            icon: Icon(Icons.person),
            label: 'Name',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: genderController,
            hint: 'Update your Gender',
            label: 'Gender',
            icon: Icon(Icons.text_fields),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: emailController..text = widget.userEmail,
            hint: 'Update your email',
            label: 'Email',
            icon: Icon(Icons.email),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: idController,
            hint: 'i.e, 20200001',
            icon: Icon(Icons.perm_identity),
            label: 'ID',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: levelController,
            hint: 'Update your level',
            label: 'Level',
            icon: Icon(Icons.numbers),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            text: 'Save Changes',
            onPressed: () async {
              saveChanges(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            text: 'My Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(userEmail: widget.userEmail),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
