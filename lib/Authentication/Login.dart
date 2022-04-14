import 'package:checkmate_mobile_app/Entities/BookingRecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final String _username = 'demo';
  final String _password = 'demo';

  String _usernameInput;
  String _passwordInput;

  bool _passwordObscured = true;
  bool _loginInfoIncorrect = false;

  @override
  void initState() {
    BookingRecord.loadBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('CheckMate'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _upperSpacingBox(),
                    _lowerSpacingBox(),
                    _iconBanner(),
                    _lowerSpacingBox(),
                    _userNameTextField(),
                    _lowerSpacingBox(),
                    _passwordTextField(),
                    _lowerSpacingBox(),
                    _loginButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Widget functions
  Widget _upperSpacingBox() {
    return SizedBox(height: 60);
  }

  Widget _lowerSpacingBox() {
    return SizedBox(height: 30);
  }

  Widget _iconBanner() {
    return SvgPicture.asset(
      'assets/logo_banner.svg',
      height: MediaQuery.of(context).size.width * 0.23084, //ratio
    );
  }

  Widget _userNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (input) => _checkUserName(),
      onChanged: (input) {
        _loginInfoIncorrect = false;
        _usernameInput = input;
      },
    );
  }

  Widget _passwordTextField() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: this._passwordObscured,
            enableSuggestions: false,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) => _checkPassword(),
            onChanged: (input) {
              _loginInfoIncorrect = false;
              _passwordInput = input;
            }),
        Container(
            height: 59,
            child: IconButton(
              icon: Icon(
                this._passwordObscured
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() => this._passwordObscured = !this
                    ._passwordObscured); //toggle whether the password is hidden
              },
            )),
      ],
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      child: Container(
        width: 50,
        height: 20,
        child: Center(
          child: Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white, fontSize: 13),
          ),
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
      onPressed: () {
        //dismiss the keyboard from screen (if it do not)
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        _login();
      },
    );
  }

  Future<void> _login() async {

    if (_loginFormKey.currentState.validate())
    {
      if(_usernameInput == _username && _passwordInput == _password)
      {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
      }
      else //incorrect input from user
      {
        _loginInfoIncorrect = true;
      }
    }
    //highlight the error to signal unsuccessful login (if necessary)
    _loginFormKey.currentState.validate();
  }

  //Validation helper functions
  String _checkUserName() {
    if (_usernameInput == null || _usernameInput.isEmpty) {
      return 'User name cannot be empty.';
    }
    if (_loginInfoIncorrect) {
      return 'The user name or password is incorrect.';
    }
    return null;
  }

  String _checkPassword() {
    if (_passwordInput == null || _passwordInput.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (_loginInfoIncorrect) {
      return 'The user name or password is incorrect.';
    }
    return null;
  }
}