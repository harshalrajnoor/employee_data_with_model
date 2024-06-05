import 'package:dummy/api_services.dart';
import 'package:dummy/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  EmployeeModel employeeModel = EmployeeModel();
  bool isLoading = true;

  _getEmployeeData() async {
    ApiServices().getEmployeeData().then((value) {
      setState(() {
        employeeModel = value!;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error);
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Data'),
        actions: [
          IconButton(
              onPressed: _getEmployeeData, icon: const Icon(Icons.refresh))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: employeeModel.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(employeeModel.data![index].id.toString()),
                  subtitle:
                      Text(employeeModel.data![index].employeeName.toString()),
                );
              }),
    );
  }
}
