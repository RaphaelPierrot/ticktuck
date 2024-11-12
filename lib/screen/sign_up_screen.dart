import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/data/global.dart';
import 'package:tiktuck/screen/login_screen.dart';
import 'package:tiktuck/widget/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  final TextEditingController _usernameController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Register',style: TextStyle(fontSize: 25,color: tipo,fontWeight: FontWeight.w900),),
          const SizedBox(height: 25,),
          Stack(children: [CircleAvatar(radius: 64,backgroundImage:const AssetImage('img/profilephoto.jpg') ,backgroundColor: backgroundColor,),
          Positioned(
            bottom: -10,
            left: 80,
            child: IconButton(icon: Icon(Icons.add),onPressed: () =>
            authController.pickImage(),
        ))],),
          Container(width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextInputField(
            controller: _usernameController,
            icon: Icons.person,
            labeltext: 'Username',
          ),),
          
          const SizedBox(height: 25,),
          Container(width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextInputField(
            controller: _emailController,
            icon: Icons.email,
            labeltext: 'Email',
          ),),
          const SizedBox(height: 25,),
          Container(width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextInputField(
            controller: _passwordController,
            icon: Icons.password,
            labeltext: 'Password',
            isObscure: true,
          ),),
          const SizedBox(height: 25,),
          Container(width: MediaQuery.of(context).size.width,
          height: 50,          margin: const EdgeInsets.symmetric(horizontal: 20),

          decoration: BoxDecoration(color: tipoUnselected,borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: InkWell(
            onTap: (){authController.registerUser(_usernameController.text, _emailController.text, _passwordController.text, authController.profilePhoto);},
            child: Center(child: Text('Register',style: TextStyle(fontSize: 20,color: tipo,fontWeight: FontWeight.w700),))),),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Text('Already have an account ? ',style: TextStyle(fontSize: 20,color: tipo,),),
          InkWell(
            onTap: () {Get.off(()=> LoginScreen());
              
            },
            child: Text('Login',style: TextStyle(fontSize: 20,color: tipoUnselected,),))],)
        ],),
      ),

    );
  }
}