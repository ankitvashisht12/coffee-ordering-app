
import 'package:coffee_ordering_app/services/auth.dart';
import 'package:coffee_ordering_app/shared/loader.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  String email = "";
  String password = "";
  String error = "";
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  Widget form(){
    return Form(
      key: _formkey,
        child: Column(
        children: <Widget>[
          TextFormField(                                      // Email
            autofocus: true,
            onChanged: (val){
              setState(() {
                email = val;
              });
            },
            validator: (val) => val.isEmpty ? "Enter valid email !": null,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: TextStyle(
                
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          SizedBox(height: 10.0,),

          TextFormField(                                         // Password
            autofocus: true,
            obscureText: true,
            validator: (val) => val.length < 6 ? "Enter 6+ character long password !": null,
            onChanged: (val){
              setState(() {
                password = val;
              });
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: TextStyle(
                
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          SizedBox(height: 20.0,),

          SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: 40,
              child: FlatButton(
              onPressed: () async{
                if(_formkey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      error = "Invalid Email and Password !";
                      loading = false; 
                    });
                  }
                }
              },
              color: Colors.brown[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
               
                Container(
                  height: 300.0,
                  width: 300.0,
                  child: Image.asset('assets/images/coffeeLogo1.png')
                ),

                SizedBox(height: 20.0,),

                Text("Login",
                  style: TextStyle(
                   
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20.0,),

                form(),

                SizedBox(height: 10.0,),
                Divider(
                  color: Colors.grey,
                ),

                Center(
                  child: FlatButton(
                      onPressed: (){
                       
                      
                        widget.toggleView();
                      
                      },              
                      child: RichText(
                      text: TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(color: Colors.black, fontFamily: 'ProductSans'),
                        children: <TextSpan>[
                          
                          TextSpan(text: 'Sign Up here', style: TextStyle(color: Colors.blue)),
                          
                        ],
                      ),
                    ),
                  ),

                ),

                SizedBox(height: 30.0,),
                Center(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,

                    ),
                  ),
                )
                

              ],
            ),
          ),
        ),
      ),
    );
  }
}