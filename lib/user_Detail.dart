import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waggy_tail/upload_image.dart';


class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  int myIndex = 0;
  Uint8List? _image;
  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'user_account',
          style: GoogleFonts.labrada(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box_outlined,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Stack(children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2.5, color: Colors.white30),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 4,
                                  blurRadius: 10,
                                  color: Colors.black38.withOpacity(0.2))
                            ],
                            shape: BoxShape.circle,
                            image: _image != null
                                ? DecorationImage(
                              image: MemoryImage(_image!),
                              fit: BoxFit.cover,
                            ):
                           DecorationImage(
                                image: NetworkImage(
                                    'https://i.pinimg.com/564x/8b/1f/9f/8b1f9f145889835124f968a6aa82b79f.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: selectImage,
                          ),
                        ),
                      ),
                    ]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '5',
                              style: GoogleFonts.laila(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Posts',
                              style: GoogleFonts.laila(fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '100',
                              style: GoogleFonts.laila(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Follower',
                              style: GoogleFonts.laila(fontSize: 16),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '50',
                              style: GoogleFonts.laila(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Following',
                              style: GoogleFonts.laila(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                      title: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        'Edit Profile',
                        style: GoogleFonts.labrada(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            GoogleFonts.labrada(fontWeight: FontWeight.bold, fontSize: 16),
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), label: 'Account'),
        ],
      ),
    );
  }
}
