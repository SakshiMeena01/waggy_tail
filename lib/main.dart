import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'user_Detail.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var home = StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if(snapshot.hasData){
          return UserDetails();
        }
        return const Account();
      }
  );
  runApp(MaterialApp(
    home: home, // Assign the variable here
    debugShowCheckedModeBanner: false,
  ));
}
class waggy_tails extends StatelessWidget {
  const waggy_tails({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton.extended(
              elevation: 0,
              label: Text(
                'Woof',
                style: GoogleFonts.labrada(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              icon: const Icon(Icons.arrow_circle_right_outlined),
              onPressed: () {
                // Navigate to Account screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Account()),
                );
              },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
          body: Center(
              child: Column(
            children: [
              const waggyTailsListview(),
              Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints.expand(
                  width: 300,
                  height: 450,
                ),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo,
                      offset: Offset(0, 2),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/11/ca/33/11ca33da0de3a122c51ef8ad44429c05.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 20,
                      child: Text('Furry friendships start with a swip-',
                          style: GoogleFonts.laBelleAurore(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text("meet your paw-some companion !",
                          style: GoogleFonts.laBelleAurore(
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ],
          )));
  }
}

class waggyTailsListview extends StatelessWidget {
  const waggyTailsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        children: [
          ListTile(
            leading: Image.network(
              'https://i.pinimg.com/564x/6f/0d/9f/6f0d9f1e5d853e4a2845f5f0feb5989a.jpg',
            ),
            title: Text('waggytails',
                style: GoogleFonts.labrada(
                    fontSize: 25, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
