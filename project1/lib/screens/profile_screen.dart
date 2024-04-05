import 'package:flutter/material.dart';
import 'package:project1/widgets/custom_view_card.dart';
import 'package:project1/widgets/custum_button.dart';
import 'package:project1/DatabaseHelper.dart'; // Import your DatabaseHelper class

class ProfilePage extends StatefulWidget {
  final String userEmail;

  ProfilePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  late String gender;
  late String email;
  late String studentId;
  late String level;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Map<String, dynamic>? userData =
        await dbHelper.getUserDataByEmail(widget.userEmail);
    if (userData != null) {
      setState(() {
        name = userData['name'];
        gender = userData['gender'];
        email = userData['email'];
        studentId = userData['studentId'];
        level = userData['level'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(radius: 90, child: Icon(Icons.person, size: 90)),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, 'EditProfilePage');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CustomCard(
            title: 'Name',
            subTitle: name ?? '',
          ),
          SizedBox(height: 5),
          CustomCard(
            title: 'Gender',
            subTitle: gender ?? '',
          ),
          SizedBox(height: 5),
          CustomCard(
            title: 'Email',
            subTitle: email ?? '',
          ),
          SizedBox(height: 5),
          CustomCard(
            title: 'Student ID',
            subTitle: studentId ?? '',
          ),
          SizedBox(height: 5),
          CustomCard(
            title: 'Level',
            subTitle: level ?? '',
          ),
          SizedBox(height: 20),
          CustomButton(
            text: 'Edit Profile',
            onPressed: () {
              Navigator.pushNamed(context, 'EditProfilePage');
            },
          )
        ],
      ),
    );
  }
}
