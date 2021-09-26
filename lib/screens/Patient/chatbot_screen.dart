import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:telehealth_bh_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telehealth_bh_app/business_logic/services/patient_services.dart';

class ChatbotScreen extends StatefulWidget {
  static final String id = 'ChatbotScreen';
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool isWriting = false;

  // // TODO DialogflowGrpc class instance
  // DialogflowGrpcV2Beta1? dialogflow;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initPlugin();
  // }

  // Future<void> initPlugin() async {
  //
  //   // TODO Get a Service account
  //   // Get a Service account
  //   final serviceAccount = ServiceAccount.fromString(
  //       '${(await rootBundle.loadString('assets/credentials.json'))}');
  //   // Create a DialogflowGrpc Instance
  //   dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
  // }
  //
  void handleSubmitted(text) async {
    print(text);
    _textController.clear();
    setState(() {
      isWriting = false;
    });

    //TODO Dialogflow Code
    ChatMessage message = ChatMessage(
      text: text,
      name: Provider.of<PatientServices>(context, listen: false).patient.name,
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });
    //TODO: UNCOMMENT AFTER ADDING THE DEPENDENCY
    // DetectIntentResponse data = await dialogflow!.detectIntent(text, 'en-US');
    // String fulfillmentText = data.queryResult.fulfillmentText;
    // if (fulfillmentText.isNotEmpty) {
    //   ChatMessage botMessage = ChatMessage(
    //     text: fulfillmentText,
    //     name: "Bot",
    //     type: false,
    //   );
    //
    //   setState(() {
    //     _messages.insert(0, botMessage);
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D47A1),
        centerTitle: true,
        titleTextStyle: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        title: Text(
          'Chatbot',
          style: kAppBarTextStyle.copyWith(fontSize: 16.sp),
        ),
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          child: Column(children: <Widget>[
            Flexible(
                child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
            Divider(
              height: 2.h,
              thickness: 1.w,
              color: Color(0xFF757575),
            ),
            Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).accentColor),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            controller: _textController,
                            onSubmitted: handleSubmitted,
                            onChanged: (String? newVal) {
                              if (newVal != null) {
                                if (newVal.trim().isEmpty) {
                                  setState(() {
                                    isWriting = false;
                                  });
                                } else {
                                  setState(() {
                                    isWriting = true;
                                  });
                                }
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: "Send a message",
                              hintStyle: kDropdownHintTextStyle.copyWith(
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 20.w,
                            ),
                            onPressed: (isWriting)
                                ? () => handleSubmitted(_textController.text)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ])),
    );
  }
}

//------------------------------------------------------------------------------------
// The chat message balloon
//
//------------------------------------------------------------------------------------
class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.name, required this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: EdgeInsets.only(right: 16.w),
        child: CircleAvatar(
          backgroundColor: Color(0xFF0D47A1).withOpacity(0.75),
          foregroundColor: Colors.white,
          radius: 20.w,
          child: new Text(
            'B',
            style: kCircleAvatarChatbotCharacter.copyWith(fontSize: 25.sp),
          ),
        ),
      ),
      new Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: kChatbotSenderNameTextStyle.copyWith(fontSize: 13.sp)),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(text,
                  style: kTypedMessageTextStyle.copyWith(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //Display user name
            Text(
              this.name.split(" ")[0],
              style: kChatbotSenderNameTextStyle.copyWith(fontSize: 13.sp),
            ),
            //Display user message
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(text.trim(),
                  style: kTypedMessageTextStyle.copyWith(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 16.w),
        child: CircleAvatar(
          backgroundColor: Color(0xFF0D47A1).withOpacity(0.85),
          foregroundColor: Colors.white,
          radius: 20.w,
          child: Text(
            this.name[0],
            style: kCircleAvatarChatbotCharacter.copyWith(fontSize: 25.sp),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
