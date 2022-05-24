import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _imagePlaceHolder =
      'https://cardiomiracle.byhealthmeans.com/wp-content/themes/hm-webinar-parent/images/speaker-placeholder.png';
  Uint8List? _image;
  bool _isLoading = false;

  void _selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(_imagePlaceHolder),
                        ),
                  Positioned(
                    right: 0,
                    bottom: -10,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: _selectImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  labelText: 'Enter your userName',
                  keyboardType: TextInputType.text,
                  textController: _userNameController),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  labelText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textController: _emailController),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                labelText: 'Enter your password',
                textController: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  labelText: 'Enter Bio',
                  keyboardType: TextInputType.text,
                  textController: _bioController),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  String res = await AuthMethods().signUpUser(
                      userName: _userNameController.text,
                      password: _passwordController.text,
                      email: _emailController.text,
                      bio: _bioController.text,
                      imageFile: _image);
                  setState(() {
                    _isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(res)));
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(8),
                  //   border: Border.all(color: primaryColor, width: 1),
                  // ),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       child: Text("Don't you have an accoutn?"),
              //       padding: EdgeInsets.symmetric(vertical: 8),
              //     ),
              // GestureDetector(
              //   onTap: () async {
              //     String res = await AuthMethods.signUpUser(
              //         userName: _userNameController.text,
              //         password: _passwordController.text,
              //         email: _emailController.text,
              //         bio: _bioController.text,
              //         imageFile: _image);
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(SnackBar(content: Text(res)));
              //   },
              //   child: Container(
              //     child: Text(
              //       "Sign up",
              //       style: TextStyle(
              //         color: blueColor,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              //   ),
              // ),
              // ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
