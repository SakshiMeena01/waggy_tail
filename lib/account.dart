
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waggy_tail/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
final _firebase = FirebaseAuth.instance;

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}


class _AccountState extends State<Account> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';


  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    try {
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

      }
    }on FirebaseAuthException catch (error) {
      if (
      error.code == 'email-already-in-use') {
        //
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Authentication Failed'),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: NetworkImage(
                  'https://t4.ftcdn.net/jpg/02/64/67/03/360_F_264670302_bj5PZAIjU8OS04dWJZoUKWVgj3Jj7RCY.jpg'),
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              children: [
                const waggyTailsListview(),
                Container(
                  padding: const EdgeInsets.only(
                    top: 23,
                    right: 35,
                    left: 35,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Please enter your name',
                              suffixStyle: GoogleFonts.antic(fontSize: 14,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        ),
                        const SizedBox(height: 12,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Please enter your email',
                              suffixStyle: GoogleFonts.antic(fontSize: 14,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        const SizedBox(height: 12,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Please enter your password',
                              suffixStyle: GoogleFonts.antic(fontSize: 14,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .length < 6) {
                              return 'Password must be of 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(height: 24,),
                        ElevatedButton(onPressed: _submit,
                            child: Text(_isLogin ? 'Login' : 'Sign Up',
                              style: GoogleFonts.halant(
                                  fontSize: 24, fontWeight: FontWeight.bold),)),
                        TextButton(onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                          child: Text(_isLogin
                              ? 'Create an account'
                              : 'I have already account.'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class waggyTailsListview extends StatelessWidget {
  const waggyTailsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView(
        children: [
          ListTile(
              leading: Image.network(
                'https://i.pinimg.com/564x/6f/0d/9f/6f0d9f1e5d853e4a2845f5f0feb5989a.jpg',
              ),
              title: Text('waggytails',
                  style: GoogleFonts.labrada(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              trailing: IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const waggy_tails()),);
              }, icon: const Icon(Icons.arrow_back))
          )
        ],
      ),
    );
  }
}
