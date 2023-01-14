import 'dart:js';
import 'package:flutter/material.dart';
import 'package:morse_code_translator/morse_code_translator.dart';

 String text_to_translate =" ";
 String _translatedText= " ";
 String text_insert =" ";
 String show_text =" hier wird es übersetzt... ";
 final textController = TextEditingController();
MorseCode  meroMorseCode = MorseCode();


void main() { runApp(myApp());}
final morseCodes = {
  'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.',
  'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..',
  'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.',
  'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
  'Y': '-.--', 'Z': '--..',
  '1': '.----', '2': '..---', '3': '...--', '4': '....-', '5': '.....',
  '6': '-....', '7': '--...', '8': '---..', '9': '----.', '0': '-----',
  ' ': '/',
};


class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Morse - Translator",
      home: const MyHomePage(title: "Morse Übersetzer"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage ( {super.key, required this.title});
  final String title;
  @override
_MyHomePageState createState() => _MyHomePageState();
}
enum SingingCharacter { dmu, mdu }

class _MyHomePageState extends State<MyHomePage> {
  static const appTitle = " Morse-Deusch - Übersetzer";
//var selectedValue_mdu = SingingCharacter.mdu;
//var selectedValue_dmu= SingingCharacter.dmu;
  SingingCharacter? _character = SingingCharacter.dmu;
  void translate() {
    text_insert = textController.text;
    if(_character ==SingingCharacter.dmu) {

    _translatedText=" ";
    setState(() {



      if (text_insert.length<=199) {
        text_to_translate = text_insert.toUpperCase();
        for (int i = 0; i < text_to_translate.length; i++) {
          _translatedText += (morseCodes[text_to_translate[i]]! + ' ')!;
        }
        show_text = "=>   $_translatedText";

      } else {
        text_insert =" ";
        show_text= "zu langer Text! Text darf nicht länger als 200 Zeichen sein!";
      }});}
  else if (_character==SingingCharacter.mdu) {

      setState(() {
        show_text = meroMorseCode.deCode(text_insert);
      });

    }

  }


  void clear() {
    setState(() {
      textController.clear();
      text_insert=" ";
      show_text="hier wird es übersetzt...";});}



@override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body:
     Container(
         child:
          Column (
            children: [
          Row(

            children:   <Widget>[
              Expanded( child:
          RadioListTile(
              title: const Text('Deutsch-Morse Übersetzer'),
              value: SingingCharacter.dmu,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                _character = value;
              });
            },

        ),),
      Expanded(child:
      RadioListTile(
        title: const Text('Morse-Deutsch Übersetzer'),
          value: SingingCharacter.mdu,
          groupValue: _character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _character = value;
            });
          },

      ),
    ),
      ],
    ),

              SizedBox(height: 45),
              TextField(
                  decoration: InputDecoration(hintText: "  hier Text eingeben"),
                  controller: textController,

              ),
              SizedBox(height:10),
              Row (
                  children: [
                    SizedBox(width:15),
                    ElevatedButton( onPressed: () => translate(), style: TextButton.styleFrom( backgroundColor: Colors.red), child:const Text('Übersetzen')),
                    SizedBox( width:30),
                    ElevatedButton(onPressed: () => clear(), style:TextButton.styleFrom(backgroundColor: Colors.red), child: const Text(' Eingabe löschen')),


                  ]),
              SizedBox(height:25),
              //Text("$text_insert    =>    $show_text", style: TextStyle(fontSize:25, color: Colors.red)),
              Column(
                children: [

                  SizedBox(width: 25),
                  SelectableText(text_insert,style:TextStyle(fontSize:20, color:Colors.red)),
                  SizedBox(width: 15),
                  SelectableText(show_text, style:TextStyle(fontSize:20, color:Colors.red))
                ]
              )




    
    ])),




        appBar: new AppBar(
          leading: new Icon(IconData(0xe67b, fontFamily: 'MaterialIcons')),
            backgroundColor: Colors.red,
            title: (Text(appTitle))
        ));
  }



}


