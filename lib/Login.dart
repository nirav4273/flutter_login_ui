import "package:flutter/material.dart";

class Login extends StatelessWidget{

  BoxDecoration decoration = BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.blueGrey[700],
              width: 1.0
          )
      )
  );

  TextStyle CustomTextStyle(){
    return TextStyle(
        color: Colors.white30,
        fontSize: 15.0
    );
  }

  Widget CustomSizeBox({double height}){
    return SizedBox(
      height:height,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FocusNode emailNode = FocusNode();
  FocusNode passawordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
      onTap:()=> FocusScope.of(context).requestFocus(new FocusNode()),
      child:Scaffold(
          backgroundColor: Color.fromRGBO(40, 55, 77,1.0),
          body: SingleChildScrollView(
            child: LoginPage()
          )
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  createState() => LoginState();
}

class LoginState extends State<LoginPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool loading = false;
  FocusNode emailNode;
  FocusNode passawordNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passawordNode = FocusNode();
    emailNode = FocusNode();
    loading = false;

  }

  BoxDecoration decoration = BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.blueGrey[700],
              width: 1.0
          )
      )
  );

  TextStyle CustomTextStyle(){
    return TextStyle(
        color: Colors.white30,
        fontSize: 15.0
    );
  }

  InputDecoration CustomTextDecoration({String text,IconData icon}){
    return InputDecoration(
      labelStyle: TextStyle(
          color: Colors.white30
      ),
      labelText: text,
      prefixIcon: Icon(icon,color: Colors.blueGrey[700]),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blueGrey[700]
          )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white70
        )
      ),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white70
          )
      ),
    );
  }

  Widget CustomSizeBox({double height}){
    return SizedBox(
      height:height,
    );
  }

  Widget LoginButton(BuildContext context){
    return new SizedBox(
      height: 45.0,
      width: double.infinity,
      child: new RaisedButton(
        color: Color.fromRGBO(0, 119, 119,1.0),
        child: Text("Login",style:TextStyle(color: Colors.white70),),
        onPressed: (){
//          Navigator.of(context).push(PageRouteBuilder(
//              opaque: false,
//              barrierDismissible: true,
//              barrierColor: Colors.white12,
//              pageBuilder: (context,_,__){
//                return Center(
//                  child: Container(
//                    height: 200.0,
//                    width: 200.0,
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(5.0)
//                    ),
//                  )
//                );
//              }
//          ));
          FocusScope.of(context).requestFocus(new FocusNode());
          if(_formKey.currentState.validate()){
            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2),(){
              setState(() {
                loading = false;
              });
              Scaffold.of(context).showSnackBar(new SnackBar(
                content: new Text("Login success"),

              ));
            });
          }else{
            setState(() {
              _autoValidate = true;
            });
          }
        },
      ),
    );
  }

  Widget LoginUi(){
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          CustomSizeBox(height: 80.0),
          Container(
            height: 150.0,
            child: Image.asset("imgs/drop.png"),
          ),
          CustomSizeBox(height: 50.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child:Column(
              children: <Widget>[
                Container(
                    decoration: decoration
                ),
                TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  focusNode: emailNode,
                  style: CustomTextStyle(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction:TextInputAction.next,
                  decoration: CustomTextDecoration(icon: Icons.person,text: "Email"),
                  textCapitalization: TextCapitalization.none,
                  onFieldSubmitted: (term){
                    emailNode.unfocus();
                    FocusScope.of(context).requestFocus(passawordNode);
                  },
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }else if(!new  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                      return "Plase enter valid email";
                    }
                  },
                ),
                TextFormField(
                  enabled: true,
                  enableInteractiveSelection: true,
                  obscureText: true,
                  textInputAction:TextInputAction.done,
                  style: CustomTextStyle(),
                  focusNode: passawordNode,
                  decoration: CustomTextDecoration(icon: Icons.lock,text: "Password"),
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }else if(value.length < 6){
                      return 'Password must be 6 digit';
                    }
                  },
                ),
                CustomSizeBox(height: 20.0),
                LoginButton(context),
                CustomSizeBox(
                    height: 30.0
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Forgot password ?",
                    style: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget LoadingIndicator(){
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white12,
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
              strokeWidth:0.7
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        LoginUi(),
        loading ? LoadingIndicator() : Container()
      ],
    );
  }
}

