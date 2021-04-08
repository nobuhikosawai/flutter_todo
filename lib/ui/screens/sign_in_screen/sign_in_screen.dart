import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/me_controller.dart';

class SignInScreen extends StatefulHookWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _emailErrorText;
  String _passwordErrorText;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final meController = useProvider(meProvider);
    final showPassword = useState<bool>(false);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
              child: Column(children: [
                SizedBox(height: 124),
                // SizedBox(
                //     height: 80, width: 80, child: Image.asset('assets/logo.png')),
                SizedBox(height: 8),
                Text('Welcome', style: Theme.of(context).textTheme.headline1),
                SizedBox(height: 80),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 16.0, bottom: 16.0, top: 16.0),
                          fillColor: const Color.fromRGBO(0, 0, 0, 0.08),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          errorText: _emailErrorText,
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        validator: (value) {
                          if (value.isEmpty ||
                              !EmailValidator.validate(value)) {
                            return 'Please input your correct email address.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 16.0, bottom: 16.0, top: 16.0),
                            fillColor: const Color.fromRGBO(0, 0, 0, 0.08),
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_rounded),
                            errorText: _passwordErrorText,
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  showPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromRGBO(0, 0, 0, 0.6)),
                              onPressed: () =>
                                  showPassword.value = !showPassword.value,
                            )),
                        obscureText: !showPassword.value,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please input your password';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          _formKey.currentState.save();
                        },
                        onSaved: (value) async {
                          if (_formKey.currentState.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            try {
                              await meController.signIn(
                                  email: email, password: password);
                            } catch (error) {
                              await showDialog<void>(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('${error.toString()}'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 48),
                      SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all(
                                  const StadiumBorder()),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(top: 16, bottom: 16)),
                            ),
                            onPressed: () async {
                              _formKey.currentState.save();
                            },
                            child: Text('Log in',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                          ))
                    ],
                  ),
                )
              ])),
        ));
  }
}
