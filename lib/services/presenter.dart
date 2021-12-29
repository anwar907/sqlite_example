import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/data/controller/api_service.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  ApiServices api = new ApiServices();
  LoginPagePresenter(this._view);

//Simulator login
  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError));
  }
}
