import 'package:coffee_ordering_app/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:coffee_ordering_app/services/auth.dart';

class Register extends StatefulWidget {
  
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";
  String name= "";
  String error = "";


  Widget form(){
    return Form(
      key: _formkey,
        child: Column(
        children: <Widget>[

          TextFormField(
            autofocus: true,
            onChanged: (val){
              setState(() {
                name = val;
              });
            },

            validator: (val) => val.isEmpty ? "Enter valid Name !" : null,

            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelStyle: TextStyle(
                
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          SizedBox(height: 10.0,),

          TextFormField(                                      // Email
            autofocus: true,
            validator: (val) => val.isEmpty ? "Enter valid Email !" : null,
            onChanged: (val){
              setState(() {
                email = val;
              });
            },
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
            validator: (val) => val.isEmpty ? "Enter 6+ long characters password !" : null,
            obscureText: true,
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
                  dynamic user = await _authService.registerWithEmailAndPassword(email, password);
                  if(user == null){
                    setState(() {
                      error = "please give valid email and password !";
                      loading = false;
                    });
                 
                  }
                }
              },
              color: Colors.green[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Sign Up',
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

                Center(
                  child: Text("Create Account",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 50.0,),

                form(),

                SizedBox(height: 10.0,),
                Divider(
                  color: Colors.grey,
                ),

                Center(
                  child: InkWell(
                      onTap: (){
                        widget.toggleView();
                      },
                      child: RichText(
                      text: TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(color: Colors.black, fontFamily: 'ProductSans'),
                        children: <TextSpan>[
                          
                          TextSpan(text: 'Login here', style: TextStyle(color: Colors.blue)),
                          
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
              ]  
            ),
          ),
        ),
      ),
    );
  }
}