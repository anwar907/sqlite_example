import 'package:bloc/bloc.dart';
import 'package:majootestcase/bloc/login_bloc/login_event.dart';
import 'package:majootestcase/bloc/login_bloc/login_state.dart';
import 'package:majootestcase/data/controller/api_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginBlocState> {
  @override
  // TODO: implement initialState
  LoginBlocState get initialState => LoginBlocInitialState();

  @override
  Stream<LoginBlocState> mapEventToState(LoginEvent event) async* {
    if (event is StartEvent) {
      yield LoginBlocInitialState();
    } else if (event is LoginSignEvent) {
      ApiServices apiServices = ApiServices();
      await apiServices.login(event.user.email, event.user.password);
      yield LoginBlocSuccessState();
    } else {
      yield LoginBlocErrorState(message: "Login Failure");
    }
  }
}
