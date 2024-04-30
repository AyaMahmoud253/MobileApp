import 'package:flutter/material.dart';
import 'package:project1/DatabaseHelper.dart';
import 'package:project1/screens/edit_profile_screen.dart';
import 'package:project1/widgets/custom_view_card.dart';
import 'package:project1/widgets/custum_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ProfilePage extends StatefulWidget {
  final String? userEmail;

  ProfilePage({Key? key, this.userEmail}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = 'name';
  late String gender = 'gender';
  late String email = 'email@stud.fci-cu.edu.eg';
  late String studentId = '########';
  late String level = '#';
  Uint8List? _profilePhoto;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (widget.userEmail != null) {
      DatabaseHelper dbHelper = DatabaseHelper();
      Map<String, dynamic>? userData =
          await dbHelper.getUserDataByEmail(widget.userEmail!);
      if (userData != null) {
        setState(() {
          name = userData['name'];
          gender = userData['gender'];
          email = userData['email'];
          studentId = userData['studentId'];
          level = userData['level'];
          _profilePhoto = userData['profilePhoto'];
        });
      }
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
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: _profilePhoto != null
                        ? Image.memory(
                            _profilePhoto!,
                            fit: BoxFit.cover,
                            width: 180.0,
                            height: 180.0,
                          )
                        : Icon(Icons.person, size: 90),
                  ),
                ),
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
                        _showImagePickerDialog();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(userEmail: email),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _showImagePickerDialog() async {
    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        Uint8List? imageBytes = await pickedFile.readAsBytes();
        DatabaseHelper dbHelper = DatabaseHelper();
        await dbHelper.updateProfilePhoto(widget.userEmail!, imageBytes!);
        setState(() {
          _profilePhoto = imageBytes;
        });
      }
    }
  }
}
