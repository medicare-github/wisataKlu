import 'package:flutter/material.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/models/user.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/screens/loadingScreen/loading.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AuthMode { Sigup, Login }

class Login extends StatefulWidget {
  Login({this.error});
  final String error;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();
  bool loading = false;
  String error = '';

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    loading=false;
    super.initState();
  }

  Future<void> _submitForm() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);

      if (_authMode == AuthMode.Login) {
        setState(() => loading = true);
        dynamic result = await login(_user, authNotifier);
        if (result == null) {
          setState(() {
            error = "please check email and password";
            loading = false;
          });
        }else{
          setState(() {
            error = "please check email and password";
            loading = false;
          });
        }
      } else {
        setState(() {
          loading=true;
        });
        dynamic result =await signUp(_user, authNotifier);
        if(result!=null){
          setState(() {
            error = "please check email and password";
            loading = false;
          });
        }else{
          setState(() {
            error = "Please check your email";
            loading = false;
          });
        }
      }
    }
  }

  Widget _buildDisplayNameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 18, bottom: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(FontAwesomeIcons.pen),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            hintText: "Full name",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.none, color: Colors.blue))),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Full name is required';
          }

          if (value.length < 4 || value.length > 25) {
            return 'Full name must be betweem 4 and 25characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.displayName = value;
        },
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 18, bottom: 18),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Icon(Icons.call),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          hintText: "Phone number",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 2, style: BorderStyle.none, color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.number,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Phone number is required';
          }

          if (value.length < 11 || value.length > 13) {
            return 'Full name must be betweem 11 and 13 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.phoneNumber = value;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 18, bottom: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(Icons.email),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Email",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    width: 2, style: BorderStyle.none, color: Colors.blue))),
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        onSaved: (String value) {
          _user.email = value;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 18, bottom: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(Icons.remove_red_eye),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Password",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, style: BorderStyle.none))),
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is required';
          }

          if (value.length < 8 || value.length > 20) {
            return 'Password must be betweem 8 and 20 characters';
          }

          return null;
        },
        onSaved: (String value) {
          _user.password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 18, bottom: 18),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(Icons.remove_red_eye),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Password",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.blue, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 2, style: BorderStyle.none))),
        keyboardType: TextInputType.visiblePassword,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Confirm Password is required';
          }
          if (_passwordController.text != value) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildForRegiter() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _authMode = _authMode == AuthMode.Login
                        ? AuthMode.Sigup
                        : AuthMode.Login;
                  });
                }),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Let's Get Started",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          "Create Your Account for acces Tourism north Lombok",
          style: TextStyle(
              fontSize: 13, color: Colors.black45, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _builForLogin() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Image.asset(
          "assets/cat.png",
          width: 300,
        ),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(27, 27, 27, 1),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'Login into you aplication for access',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    double widht = MediaQuery.of(context).size.width;

    return Scaffold(
      body: loading
          ? Loading()
          : Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                autovalidate: true,
                key: _formkey,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    width: widht,
                    child: Column(
                      children: <Widget>[
                        _authMode == AuthMode.Sigup
                            ? _buildForRegiter()
                            : _builForLogin(),
                        _authMode == AuthMode.Sigup
                            ? _buildDisplayNameField()
                            : Container(),
                        _buildEmailField(),
                        _authMode == AuthMode.Sigup
                            ? _buildPhoneNumberField()
                            : Container(),
                        _buildPasswordField(),
                        _authMode == AuthMode.Sigup
                            ? _buildConfirmPasswordField()
                            : Container(),
                        _authMode == AuthMode.Login ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Color.fromRGBO(27, 27, 27, 0.5),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14),
                              ),
                            )
                          ],
                        ):Container(),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          onPressed: () => _submitForm(),
                          highlightElevation: 0,
                          focusElevation: 0,
                          splashColor: Colors.white.withOpacity(0.1),
                          padding: EdgeInsets.fromLTRB(60, 17, 60, 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Color.fromRGBO(1, 72, 164, 1),
                          child: Text(
                            _authMode == AuthMode.Login ? 'Login' : 'Signup',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
//                        _authMode == AuthMode.Login
//                            ? Column(
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 8,
//                                  ),
//                                  Text(
//                                    'Or Login using',
//                                    style: TextStyle(
//                                        color: Colors.grey[600], fontSize: 12),
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                ],
//                              )
//                            : SizedBox(
//                                height: 0,
//                              ),
//                        _authMode == AuthMode.Login
//                            ? Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Spacer(
//                                    flex: 4,
//                                  ),
//                                  RaisedButton(
//                                    onPressed: () {},
//                                    highlightElevation: 0,
//                                    focusElevation: 0,
//                                    splashColor: Colors.white.withOpacity(0.1),
//                                    padding:
//                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
//                                    shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(5)),
//                                    color: Color.fromRGBO(54, 92, 139, 1),
//                                    child: Row(
//                                      children: <Widget>[
//                                        Icon(
//                                          FontAwesomeIcons.facebook,
//                                          size: 16,
//                                          color: Colors.white,
//                                        ),
//                                        SizedBox(
//                                          width: 5,
//                                        ),
//                                        Text(
//                                          'facebook',
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.bold,
//                                              color: Colors.white),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Spacer(
//                                    flex: 1,
//                                  ),
//                                  RaisedButton(
//                                    onPressed: () {},
//                                    highlightElevation: 0,
//                                    focusElevation: 0,
//                                    splashColor: Colors.white.withOpacity(0.1),
//                                    padding:
//                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
//                                    shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(5)),
//                                    color: Colors.white,
//                                    child: Row(
//                                      children: <Widget>[
//                                        Image.asset(
//                                          "assets/images/google.png",
//                                          width: widht * 0.046,
//                                        ),
//                                        SizedBox(
//                                          width: 5,
//                                        ),
//                                        Text(
//                                          'Google',
//                                          style: TextStyle(
//                                              fontSize: 14,
//                                              fontWeight: FontWeight.bold,
//                                              color: Colors.black),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Spacer(
//                                    flex: 4,
//                                  ),
//                                ],
//                              )
//                            : Container(),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                _authMode == AuthMode.Login
                                    ? "Don't Have an account?"
                                    : "Already Account?",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _authMode = _authMode == AuthMode.Login
                                        ? AuthMode.Sigup
                                        : AuthMode.Login;
                                  });
                                },
                                child: Text(
                                  _authMode == AuthMode.Login
                                      ? "Sign Up"
                                      : "Login",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
