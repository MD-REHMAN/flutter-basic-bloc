// #1 TODO: imports
import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
// #2 TODO: List of employees
  List<Employee> _employeeList = [
    Employee(1, 'Employee 1', 10000),
    Employee(2, 'Employee 2', 20000),
    Employee(3, 'Employee 3', 30000),
    Employee(4, 'Employee 4', 40000),
    Employee(5, 'Employee 5', 50000),
  ];

// #3 TODO: Stream Controllers
  final _employeeListSteamController = StreamController<List<Employee>>();

  // for inc and dec
  final _employeeSalaryIncrementSteamController = StreamController<Employee>();
  final _employeeSalaryDecrementSteamController = StreamController<Employee>();

// #4 TODO: Stream Sink getter
  Stream<List<Employee>> get employeeListStream =>
      _employeeListSteamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListSteamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementSteamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementSteamController.sink;

// #5 TODO: Constructor - add data; listen to change
  EmployeeBloc() {
    _employeeListSteamController.add(_employeeList);

    _employeeSalaryIncrementSteamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementSteamController.stream.listen(_decrementSalary);
  }

// #6 TODO: Core Functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * .2;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * .2;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

// #7 TODO: dispose
  void dispose() {
    _employeeListSteamController.close();
    _employeeSalaryIncrementSteamController.close();
    _employeeSalaryDecrementSteamController.close();
  }
}
