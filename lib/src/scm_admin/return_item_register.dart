import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnItemRegister extends StatefulWidget {
  ReturnItemRegister({Key? key}) : super(key: key);

  @override
  State<ReturnItemRegister> createState() => _ReturnItemRegisterState();
}

class _ReturnItemRegisterState extends State<ReturnItemRegister> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController barCodecontroller = TextEditingController();
    final FocusNode focusBarCode = FocusNode();

    void _processValue(String value) {
      print("Entered value: $value");

      barCodecontroller.clear();

      FocusScope.of(context).requestFocus(focusBarCode);
    }

    void _handleTextChanged() {
      String value = barCodecontroller.text.trim();
      if (value.isNotEmpty) {
        _processValue(value);
        barCodecontroller.clear();
      }
    }

    @override
    void initState() {
      super.initState();
      focusBarCode.requestFocus();
      barCodecontroller.addListener(_handleTextChanged);
    }

    @override
    void dispose() {
      barCodecontroller.dispose();
      focusBarCode.dispose();
      super.dispose();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.7,
          title: Text(
            'SCM반품등록',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
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
                      enabled: true,
                      autocorrect: false,
                      autofocus: true,
                      controller: barCodecontroller,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      focusNode: focusBarCode,
                      onSubmitted: (val) {
                        _processValue(val);
                      },
                      decoration: InputDecoration(hintText: '바코드를 입력하세요'),
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
                    return Container(
                      margin: const EdgeInsets.all(3),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                      ),
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
                'SCM반품등록',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
