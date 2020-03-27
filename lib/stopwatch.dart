import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  List colors=[Colors.white30,Colors.lime, Colors.greenAccent, Colors.cyan, Colors.white, Colors.yellow, Colors.deepPurpleAccent,Colors.tealAccent];
  bool play=false, buttonState=false;
  int h=0, m=0, s=0, i=0, l=0;
  Timer _timer;

  static const oneSec=const Duration(seconds: 1);
  //To start the Stopwatch. Contains logic for periodic time update , color animations index update, logo value updates etc.
  void startTimer(){
    play=!play;
    buttonState=!buttonState;

    _timer=Timer.periodic(oneSec, (timer) {
      setState(() {

        if(play){
          if(s<59){
            s+=1;
          }else if(m<59){
            m+=1;
            s=0;
          }else{
            m=0;
            s=0;
            h+=1;
          }
          if(i<7){
            i+=1;
          }else{
            i=0;
          }
          if(l<2){
            l+=1;
          }else{
            l=0;
          }
        }
      });
    });
  }

  // To Pause the stopwatch.
  void pauseTimer(){
    setState(() {
      l=0;
      i=0;
      buttonState=!buttonState;
      play=!play;
      _timer.cancel();
    });
  }

  // To reset the stopwatch.
  void resetTimer(){
    setState(() {
      i=0;
      l=0;
      buttonState=false;
      play=false;
      _timer.cancel();
      s=0;
      m=0;
      h=0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
  // UI design part.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:5 , centerTitle: true, backgroundColor: colors[i],
        title: Text("MY  STOPWATCH", style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black87, letterSpacing: 2),),
      ),
      backgroundColor: Color(0xff22264C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            FlutterLogo(
              size: 160,
              style: FlutterLogoStyle.values[l],
              textColor: colors[i],

            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),color: colors[i]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 12),
                child: Text(h.toString().padLeft(2, "0")+":"+m.toString().padLeft(2, "0")+":"+s.toString().padLeft(2, "0"),
                  style: TextStyle(fontSize: 70,letterSpacing: 1),),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 50,
              width: 160,
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                onPressed:play? pauseTimer :startTimer,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(buttonState?"Pause":"Start", style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1),),
                      SizedBox(width: 3,),
                      Icon(buttonState?Icons.pause:Icons.play_circle_filled,size: 30,color: Colors.white,),

                    ]),
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10,),
            Opacity(
              opacity: 0.8,
              child: SizedBox(
                height: 40,
                width: 100,
                child: RaisedButton(onPressed: resetTimer,
                  child: Text("Reset", style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1),),
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
            Expanded(child: Container()),
            Text("Made with ❤ by Auro ", style: TextStyle(color:(i!=0)?colors[i]:Colors.white,fontSize: 18),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
