import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart'; 

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  _AttendanceViewState createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  List<dynamic> attendance = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
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

      // Make the API call
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/get_attendance.php?user_id=$userId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            attendance = data['attendance'];
            errorMessage = null;
          });
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'An error occurred.';
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
        title: Text('Attendance View'),
      ),
      body: errorMessage != null
          ? Center(child: Text(errorMessage!))
          : attendance.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: attendance.length,
                  itemBuilder: (context, index) {
                    final record = attendance[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text('Month: ${record['month']}, Year: ${record['year']}'),
                        subtitle: Text('Days Worked: ${record['days_worked']}'),
                      ),
                    );
                  },
                ),
    );
  }
}
