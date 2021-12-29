import 'package:bloc/bloc.dart';
import 'package:majootestcase/bloc/register_bloc/register_event.dart';
import 'package:majootestcase/bloc/register_bloc/register_state.dart';
import 'package:majootestcase/data/helper/database-helper.dart';
import 'package:majootestcase/models/user.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterBlocState> {
  @override
  // TODO: implement initialState
  RegisterBlocState get initialState => RegisterBlocInitState();

  @override
  Stream<RegisterBlocState> mapEventToState(RegisterEvent event) async* {
    if (event is StartEvent) {
      yield RegisterBlocInitState();
    } else if (event is RegisterDataEvent) {
      var user = User(
          email: event.email, password: event.password, userName: event.nama);
      var db = DatabaseHelper();
      db.saveUser(user);

      yield RegisterBlocSuccessState();
    }
  }
}
