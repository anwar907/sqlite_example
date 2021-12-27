import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_state.dart';

class AuthBlocCubit extends Cubit<AuthBlocState> {
  AuthBlocCubit() : super(AuthBlocInitialState());

  void fetch_history_login() async{
    emit(AuthBlocInitialState());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool("is_logged_in");
    if(isLoggedIn== null){
      emit(AuthBlocLoginState());
    }else{
      if(isLoggedIn){
        emit(AuthBlocLoggedInState());
      }else{
        emit(AuthBlocLoginState());
      }
    }
  }

  void login_user(User user) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emit(AuthBlocLoadingState());
    await sharedPreferences.setBool("is_logged_in",true);
    String data = user.toJson().toString();
    sharedPreferences.setString("user_value", data);
    emit(AuthBlocLoggedInState());
  }
}
