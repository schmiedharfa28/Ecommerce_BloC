import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/auth/register/register_cubit.dart';
import 'package:training_magang/view/auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController telp = TextEditingController();

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit())
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            alignment: Alignment.center,
            child: Form(
              key: _keyForm,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 75,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: fullname,
                      validator: (val) {
                        return val!.isEmpty
                            ? 'Fullname Tidak Boleh Kosong'
                            : null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Fullname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        fillColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: telp,
                      validator: (val) {
                        return val!.isEmpty ? 'Telp Tidak Boleh Kosong' : null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Telp',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.call),
                        fillColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (val) {
                        return val!.isEmpty ? 'Email Tidak Boleh Kosong' : null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.email),
                        fillColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (val) {
                        return val!.isEmpty
                            ? 'Password Tidak Boleh Kosong'
                            : null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                        fillColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                      RegisterCubit cubit = context.read<RegisterCubit>();
                      if (state is RegisterLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is RegisterError) {
                        log('${state.message}');
                      }
                      return MaterialButton(
                          color: Colors.blue,
                          minWidth: 200,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {
                            if (_keyForm.currentState!.validate()) {
                              await cubit.registerAccount(
                                  context,
                                  fullname.text,
                                  email.text,
                                  telp.text,
                                  password.text);
                            }
                          });
                    }),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: Text('Anda sudah punya akun? silahkah login'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
