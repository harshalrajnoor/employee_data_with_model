import 'dart:convert';

import 'employee_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<EmployeeModel?> getEmployeeData() async {
    try {
      var url = "https://dummy.restapiexample.com/api/v1/employees";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        EmployeeModel model = EmployeeModel.fromJson(
          json.decode(response.body),
        );

        return model;
      }
    } catch (e) {
      print(e);
    }
  }
}
