import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/register_bloc/register_bloc.dart';
import 'package:majootestcase/bloc/register_bloc/register_event.dart';
import 'package:majootestcase/bloc/register_bloc/register_state.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/ui/extra/loading.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isObscurePassword = true;
  TextController _password = TextController();
  TextController _email = TextController();
  TextController _username = TextController();
  final registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    var loginBtn = CustomButton(
      text: 'Register',
      onPressed: _submit,
      height: 100,
    );

    var loginForm = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Buat Akun Baru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Masukan datamu yang valid',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Username',
                      controller: _username,
                    ),
                    CustomTextFormField(
                      isEmail: true,
                      validator: (val) {
                        if (val.isEmpty || val != null) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return null;
                          } else {
                            return "Masukkan e-mail yang valid";
                          }
                        } else {
                          return null;
                        }
                      },
                      label: 'Email',
                      controller: _email,
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      controller: _password,
                      isObscureText: _isObscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        },
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            BlocListener<RegisterBloc, RegisterBlocState>(
              bloc: registerBloc,
              listener: (context, state) {
                if (state is RegisterBlocLoadingState) {
                  return LoadingIndicator();
                }
                if (state is RegisterBlocSuccessState) {
                  _showSnackbar("Register Berhasil");
                  Future.delayed(Duration(seconds: 4), () {
                    Navigator.pop(context);
                  });
                }
              },
              child: loginBtn,
            )
          ],
        ));
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: scaffoldKey,
      body: Container(
          padding: const EdgeInsets.only(top: 20.0), child: loginForm),
    );
  }

  void _showSnackbar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        registerBloc
          ..add(RegisterDataEvent(
              email: _email.value,
              nama: _username.value,
              password: _password.value));
      });
    }
  }
}
