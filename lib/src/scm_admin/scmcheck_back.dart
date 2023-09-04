import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ScmCheck extends StatefulWidget {
  ScmCheck({Key? key}) : super(key: key);

  @override
  State<ScmCheck> createState() => _ScmCheckState();
}

class _ScmCheckState extends State<ScmCheck> {
  
//   var focusNode = FocusNode(onKey: (node, event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
//         // Do something
//         // Next 2 line needed If you don't want to update the text field with new line.
//         // node.unfocus(); 
//         // return true;
//     }
//     return false;

// });

  var focusNodes = FocusNode();



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.7,
          title: Text(
            'SCM 수입검사',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: const Text(
                        '바코드',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: RawKeyboardListener(
                      focusNode: focusNodes,
                      onKey: (e){
                        if(e.isKeyPressed(LogicalKeyboardKey.enter)){
                          print('enter');
                        }
                      },
                      child: Text(
                        'fkfkfk'
                        //autofocus: true,
                        //decoration: InputDecoration(hintText: '바코드를 입력하세요'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(7),
                height: 465,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 3,
                    )
                  ],
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(3),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        )
                      ],
                    );
                  },
                  // itemCount: items.length,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.grey,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.border_color, color: Colors.white),
              SizedBox(
                width: 3,
              ),
              Text(
                ' 수입검사',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}