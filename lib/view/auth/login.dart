import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_magang/cubit/auth/login/login_cubit.dart';
import 'package:training_magang/view/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<LoginCubit>(create: (context) => LoginCubit())],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            alignment: Alignment.center,
            child: Form(
              key: _keyForm,
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
                  BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                    LoginCubit cubit = context.read<LoginCubit>();
                    if (state is LoginLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is LoginError) {
                      log('${state.message}');
                    }
                    return MaterialButton(
                        color: Colors.blue,
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () async {
                          if (_keyForm.currentState!.validate()) {
                            await cubit.loginAccount(
                                context, email.text, password.text);
                          }
                        });
                  }),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => RegisterPage()));
                      },
                      child: Text('Anda Belum punya akun? silahkah daftar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
