import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart'; // Import ApiConfig class

class PayslipView extends StatefulWidget {
  const PayslipView({super.key});

  @override
  _PayslipViewState createState() => _PayslipViewState();
}

class _PayslipViewState extends State<PayslipView> {
  List<dynamic> payslips = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchPayslips();
  }

  Future<void> fetchPayslips() async {
    try {
      // Get user_id from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userIdString = prefs.getString('user_id');

      if (userIdString == null) {
        setState(() {
          errorMessage = 'User ID not found in shared preferences.';
        });
        return;
      }

      int userId = int.tryParse(userIdString) ?? 0;

      if (userId <= 0) {
        setState(() {
          errorMessage = 'Invalid user ID.';
        });
        return;
      }

      // Use the base URL from ApiConfig
      final String apiUrl = '${ApiConfig.baseUrl}/get_payslip.php?user_id=$userId';
      
      // Send request to the API
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            payslips = data['payslips'];
            errorMessage = null;
          });
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'Unknown error occurred.';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payslip View'),
      ),
      body: errorMessage != null
          ? Center(child: Text(errorMessage!))
          : payslips.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: payslips.length,
                  itemBuilder: (context, index) {
                    final payslip = payslips[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text('Payslip ID: ${payslip['id']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Year: ${payslip['year'] ?? 'N/A'}'),
                            Text('Month: ${payslip['month'] ?? 'N/A'}'),
                            Text('Salary: ${payslip['base_salary'] ?? 'N/A'}'),
                            Text('Pension: ${payslip['pension'] ?? 'N/A'}'),
                            Text('Penalty: ${payslip['penalty'] ?? 'N/A'}'),
                            Text('Bonus: ${payslip['bonus'] ?? 'N/A'}'),
                            Text('Addon: ${payslip['position_addon'] ?? 'N/A'}'),
                            Text('Attendance: ${payslip['attendance_days'] ?? 'N/A'}'),
                            Text('Net Pay: ${payslip['net_pay'] ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
