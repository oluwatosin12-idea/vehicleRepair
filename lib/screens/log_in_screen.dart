import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehiclerepair/controllers/app_styles.dart';
import 'package:vehiclerepair/screens/home_screen.dart';
import 'package:vehiclerepair/servides/auth_services.dart';
import 'booking_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await AuthService().login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = "Error, invalid email and password";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.splashColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: AppStyles.whiteColor,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
                    child: Text(
                      'Enter your email address and password to login',
                      style: TextStyle(
                        color: AppStyles.whiteColor,
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.35,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Form( // FIX: wrapped form
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 52,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: AppStyles.textColor,
                                fontFamily: 'Montserrat',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppStyles.dotColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppStyles.dotColor, width: 2),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: AppStyles.dotColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 52,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: AppStyles.textColor,
                                fontFamily: 'Montserrat',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppStyles.dotColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppStyles.dotColor, width: 2),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.lock_outline,
                                  color: AppStyles.dotColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: 20),
                          Text(
                            _errorMessage!,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          ),
                        ],
                        SizedBox(height: 30),
                        SizedBox(
                          width: 352,
                          height: 52,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onPressed: _isLoading ? null : _login,
                            color: AppStyles.splashColor,
                            child: _isLoading
                                ? Center(child: CircularProgressIndicator(color: Colors.white))
                                : Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppStyles.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: AppStyles.splashColor,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: AppStyles.textColor,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: AppStyles.splashColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
