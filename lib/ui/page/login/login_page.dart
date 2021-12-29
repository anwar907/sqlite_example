import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_event.dart';
import 'package:majootestcase/bloc/login_bloc/login_bloc.dart';
import 'package:majootestcase/bloc/login_bloc/login_event.dart';
import 'package:majootestcase/bloc/login_bloc/login_state.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/data/controller/api_service.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/ui/page/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/page/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> scaffoldKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;
  var authBlocCubit = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginBlocState>(
        bloc: authBlocCubit,
        listener: (context, state) {
          if (state is LoginBlocSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => HomeBlocCubit(apiServices)
                    ..add(HomeLoadedEvent(data: state.data)),
                  child: HomeBlocScreen(),
                ),
              ),
            );
          }
          if (state is LoginBlocErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 75, left: 25, bottom: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                _form(),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Login',
                  onPressed: handleLogin,
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                _register(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              if (val.isNotEmpty || val != null) {
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
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
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
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => RegisterPage()));
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    if (formKey.currentState?.validate() == true &&
        _email != null &&
        _password != null) {
      User user = User(email: _email, password: _password);

      authBlocCubit..add(LoginSignEvent(user: user));
    } else {
      SnackBar(content: Text("Gagal Login"));
    }
  }
}
