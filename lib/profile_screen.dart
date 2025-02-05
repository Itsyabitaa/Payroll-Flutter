import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart'; // Import ApiConfig class

class UpdateUserView extends StatefulWidget {
  const UpdateUserView({super.key});

  @override
  _UpdateUserViewState createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  String _userId = '';
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('user_id') ?? '';
    });
  }

  Future<void> _updateUserDetails() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final username = _usernameController.text;

    if (oldPassword.isEmpty || newPassword.isEmpty || username.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
        _successMessage = null;
      });
      return;
    }

    if (_userId.isEmpty) {
      setState(() {
        _errorMessage = 'User ID not found in shared preferences';
        _successMessage = null;
      });
      return;
    }

    final url = Uri.parse(
        '${ApiConfig.baseUrl}/update_user.php?user_id=$_userId&username=$username&old_password=$oldPassword&new_password=$newPassword');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _successMessage = data['message'];
            _errorMessage = null;
          });
        } else {
          setState(() {
            _errorMessage = data['message'];
            _successMessage = null;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to update user details';
          _successMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _successMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage != null)
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.red[100],
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (_successMessage != null)
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.green[100],
                child: Text(
                  _successMessage!,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            SizedBox(height: 20),
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'New Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserDetails,
              child: Text('Update Details'),
            ),
          ],
        ),
      ),
    );
  }
}
