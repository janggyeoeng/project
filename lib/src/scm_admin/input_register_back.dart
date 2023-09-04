import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:input_with_keyboard_control/input_with_keyboard_control.dart';

class InputRegister extends StatefulWidget {
  InputRegister({Key? key}) : super(key: key);

  @override
  State<InputRegister> createState() => _InputRegisterState();
}

class _InputRegisterState extends State<InputRegister> {
  final TextEditingController _barCodecontroller = TextEditingController();
  final FocusNode _focusBarCode = FocusNode();
  TextInputType _currentKeyboardType = TextInputType.none;
  bool _isKeyboardVisible = false;

  void _processValue(String value) {
    print("Entered value: $value");

    _barCodecontroller.clear();
    FocusScope.of(context).requestFocus(_focusBarCode);
  }

  void _toggleKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isKeyboardVisible = !_isKeyboardVisible;
    });
  }

  void _changeKeyboardType() {
    if (_currentKeyboardType == TextInputType.none) {
      _currentKeyboardType = TextInputType.text;
    } else {
      _currentKeyboardType = TextInputType.none;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _focusBarCode.unfocus();
  }

  @override
  void dispose() {
    _barCodecontroller.dispose();
    _focusBarCode.dispose();
    super.dispose();
  }

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
            'SCM입고등록',
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
                      child: TextField(
                        autofocus: true,
                        keyboardType: _currentKeyboardType,
                        focusNode: _focusBarCode,
                        controller: _barCodecontroller,
                        onSubmitted: (val) {
                          _processValue(val);
                        },
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: IconButton(onPressed: () {
                              _changeKeyboardType();
                              _toggleKeyboard();
                            } , icon: Icon(Icons.keyboard))
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _changeKeyboardType();
                        //       _toggleKeyboard();
                        //     },
                        //     child: const Icon(Icons.keyboard)),
                      ))
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
                          margin: const EdgeInsets.all(3),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
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
                '입고등록',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
