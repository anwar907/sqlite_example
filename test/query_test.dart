import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:majootestcase/data/helper/database-helper.dart';
import 'package:majootestcase/models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("mencoba query database", () async {
    var data = User(email: "anwar@mail.com", password: '1234567');
    // data.email = "anwar@mail.com";
    // data.password = '1234567';
    var result = DatabaseHelper();
    var value = await result.selectUser(data.email, data.password);
    print(value.email);
  });
}
