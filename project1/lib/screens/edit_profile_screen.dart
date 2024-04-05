import 'package:project1/widgets/custom_text_field.dart';
import 'package:project1/widgets/custum_button.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController idController = TextEditingController();

  TextEditingController levelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
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
            label: 'Mariam',
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: genderController,
            hint: 'Update your Gender',
            label: 'Female',
            icon: Icon(Icons.text_fields),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: emailController,
            hint: 'Update your email',
            label: '20200527@stud.fci-cu.edu.eg',
            icon: Icon(Icons.email),
          ),
          SizedBox(
            height: 10,
          ),
          /*CustomTextField(obsText: false,
          //controllerText: idController,
          hint: 'i.e, 20200001',
          icon: Icon(Icons.perm_identity),
          label: 'ID',),*/
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            obsText: false,
            controllerText: levelController,
            hint: 'Update your level',
            label: 'Four',
            icon: Icon(Icons.numbers),
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            text: 'Save Changes',
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            text: 'My Profile',
            onPressed: () {
              Navigator.pushNamed(context, 'ProfilePage');
            },
          )
        ],
      ),
    );
  }
}
