import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktuck/data/colors.dart';
import 'package:tiktuck/data/global.dart';
import 'package:tiktuck/screen/sign_up_screen.dart';
import 'package:tiktuck/widget/text_input_field.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();


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
          Text('Login',style: TextStyle(fontSize: 25,color: tipo,fontWeight: FontWeight.w900),),
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
            onTap: ()=> authController.loginUser(_emailController.text, _passwordController.text),
            child: Center(child: Text('Login',style: TextStyle(fontSize: 20,color: tipo,fontWeight: FontWeight.w700),))),),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Text('Don t have an account ? ',style: TextStyle(fontSize: 20,color: tipo,),),
          InkWell(
            onTap: () {Get.off(()=> SignUpScreen());
              
            },
            child: Text('Register',style: TextStyle(fontSize: 20,color: tipoUnselected,),))],)
        ],),
      ),

    );
  }
}

