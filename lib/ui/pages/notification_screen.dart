import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
  {
    String _payload = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color:  Get.isDarkMode? Colors.white : Colors.black,
            )
        ),
        elevation: 0.0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(
          _payload.toString().split('|')[0],
          style: TextStyle(
            color: Get.isDarkMode? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Text(
                    'Hello , Mounir!',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w900,
                      color: Get.isDarkMode? Colors.white : darkGreyClr,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'You have a new reminder',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode? Colors.grey[100] : darkGreyClr,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                              Icons.text_format,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[0],
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[1],
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _payload.toString().split('|')[2],
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
