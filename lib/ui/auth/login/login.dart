import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/auth/login/login_view_model.dart';
import 'package:graduation_project/ui/auth/register/register.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = "";
  String password = "";
  bool isVisible = true;
  LoginViewModel viewModel = LoginViewModel();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/login_screen_77.png"),
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5.0,sigmaX: 5.0),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .20,),
                       const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Welcome back !",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Exo"),),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      TextFormField(
                        onChanged: (value) => email = value,
                        style: const TextStyle(fontSize: 17,color: Colors.white, fontFamily: "Exo"),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(width: 1.5,color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(width: 1,color: Colors.white70)
                          ),
                          labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                              color: Colors.white70, fontFamily: "Exo"),
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email, color: Colors.white70,),
                        ),
                        validator: (value) {
                          if(value!.isEmpty)
                            {
                              return "Email is required";
                            }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      TextFormField(
                        onChanged: (value) => password = value,
                        style: const TextStyle(fontSize: 17, color: Colors.white, fontFamily: "Exo"),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 1)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(width: 1.5, color: Colors.white)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(width: 1,color: Colors.white70)
                          ),
                          labelStyle: const TextStyle(fontFamily: "Exo", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.password, color: Colors.white70,),
                          suffixIcon: IconButton( icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: Colors.white70,),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              }); },),
                        ),
                        obscureText: isVisible,
                        validator: (value) {
                          if(value!.isEmpty)
                            {
                              return "Password is required";
                            }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      Center(
                        child: ElevatedButton(onPressed: () {
                          if(formKey.currentState!.validate())
                            {
                              viewModel.login(context, email, password);
                            }
                        },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                            fixedSize: MaterialStatePropertyAll(Size(200, 50)),
                          ),
                          child: const Text("Log in", style: TextStyle(fontFamily: "Exo", fontSize: 22,color: Colors.black),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register())),
                          child: const Text("Create new account",
                              style: TextStyle(fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white)),
                        ),
                      ),
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