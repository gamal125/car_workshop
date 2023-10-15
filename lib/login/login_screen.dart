
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:workshop_app/layout/todo_layout.dart';
import '../components/components.dart';
import '../cubit/cubit.dart';
import '../register/register_screen.dart';
import '../shared/local/cache_helper.dart';
import 'cubit/maincubit.dart';
import 'cubit/state.dart';



class LoginScreen extends StatelessWidget {
 final  formKey = GlobalKey<FormState>();

 final emailController = TextEditingController();

 final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSiz = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
         if (state is LoginSuccessState) {

            CacheHelper.saveData(key: 'uId', value: state.uId);


            AppCubit.get(context).getUser(state.uId);
            AppCubit.get(context).ud=state.uId;
            AppCubit.get(context).currentIndex=0;
                navigateAndFinish(context,  Home_Layout());



      }},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,

          // appBar: AppBar(
          //   elevation: 0,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //     statusBarColor: Colors.white,
          //     statusBarIconBrightness: Brightness.dark,
          //     statusBarBrightness: Brightness.light,
          //   ),
          //   backgroundColor: Colors.white,
          // ),
          body: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
                },

                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextFormField(
                              onTap: (){
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icons.email,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                              label: 'Email',
                              hint: 'Enter your email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextFormField(
                              onTap: (){
                                // LoginCubit.get(context).emit(LoginInitialState());
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              prefix: Icons.key,
                              suffix: LoginCubit.get(context).suffix,
                              isPassword: LoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                LoginCubit.get(context).ChangePassword();
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              label: 'Password',
                              hint: 'Enter your password',
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => Center(
                                child: defaultMaterialButton(

                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Login',
                                  radius: 20,
                                ),
                              ),
                              fallback: (context){
                                 return Center(
                                      child: LoadingAnimationWidget.inkDrop(
                                        color: Colors.blue.withOpacity(.8),
                                        size: screenSiz.width / 12,
                                      ));}
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style:
                                      TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),

                                defaultTextButton(
                                  function: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'Register Now!',
                                ),
                              ],
                            ),

                            Center(
                              child: IconButton(onPressed: () {
                                LoginCubit.get(context).signInWithGoogle();
                              },
                                icon:SvgPicture.asset('assets/icon/google.svg',height: 48,width: 48,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

        );
      },
    );
  }
}
