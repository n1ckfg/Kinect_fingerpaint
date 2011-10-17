//based on oscP5parsing by andreas schlegel

import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1"; //"169.254.213.52";
int receivePort = 7110;
int sendPort = 5555;
OscP5 oscP5;
NetAddress myRemoteLocation;
//---

float[] oscData = new float[6];

void oscSetup() {
  oscP5 = new OscP5(this, receivePort);  // start osc
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
    //kinect via osceleton
      if (theOscMessage.checkAddrPattern("/joint") && theOscMessage.checkTypetag("sifff")) {
      if (theOscMessage.get(0).stringValue().equals("l_hand")) {
        oscData[0] = theOscMessage.get(2).floatValue();
        oscData[1] = theOscMessage.get(3).floatValue();
        //z[i] = theOscMessage.get(4).floatValue();
          rPosX = oscData[0] * sW;
          rPosY = abs(oscData[1]) * sH;
      }
      if (theOscMessage.get(0).stringValue().equals("r_hand")) {
        oscData[2] = theOscMessage.get(2).floatValue();
        oscData[3] = theOscMessage.get(3).floatValue();
        //z[i] = theOscMessage.get(4).floatValue();
          lPosX = oscData[2] * sW;
          lPosY = abs(oscData[3]) * sH;
      }
  }
      //touchOSC on ipad;
    if (theOscMessage.checkAddrPattern("/xy1")) {
      if (theOscMessage.checkTypetag("ff")) {  // types are i = int, f = float, s = String, ifs = all
        oscData[0] = theOscMessage.get(0).floatValue();  // commands are intValue, floatValue, stringValue
        oscData[1] = theOscMessage.get(1).floatValue();  // commands are intValue, floatValue, stringValue
          lPosX = oscData[1] * sW;
          lPosY = abs(1-oscData[0]) * sH;

    }
    }
    if (theOscMessage.checkAddrPattern("/xy2")) {
      if (theOscMessage.checkTypetag("ff")) {  // types are i = int, f = float, s = String, ifs = all
        oscData[2] = theOscMessage.get(0).floatValue();  // commands are intValue, floatValue, stringValue
        oscData[3] = theOscMessage.get(1).floatValue();  // commands are intValue, floatValue, stringValue
          rPosX = oscData[3] * sW;
          rPosY = abs(1-oscData[2]) * sH; 

       }
    }
        if (theOscMessage.checkAddrPattern("/push1")) {
      if (theOscMessage.checkTypetag("f")) {  // types are i = int, f = float, s = String, ifs = all
        oscData[4] = theOscMessage.get(0).floatValue();  // commands are intValue, floatValue, stringValue
      }
    }
        if (theOscMessage.checkAddrPattern("/push2")) {
      if (theOscMessage.checkTypetag("f")) {  // types are i = int, f = float, s = String, ifs = all
        oscData[5] = theOscMessage.get(0).floatValue();  // commands are intValue, floatValue, stringValue
      }
    }
}

void oscSend() {
  OscMessage myMessage;
  //--
  myMessage = new OscMessage("/isadora/31"); // x
  myMessage.add(rPosX);
  oscP5.send(myMessage, myRemoteLocation); 
  //--
  myMessage = new OscMessage("/isadora/32"); // y
  myMessage.add(rPosY);
  oscP5.send(myMessage, myRemoteLocation); 
  //--
  myMessage = new OscMessage("/isadora/33");  // pressure
  myMessage.add(getDist);
  oscP5.send(myMessage, myRemoteLocation); 
  //--
  myMessage = new OscMessage("/isadora/34");  // click
  myMessage.add(clicked);
  oscP5.send(myMessage, myRemoteLocation);
    //--
  myMessage = new OscMessage("/isadora/21");  // click
  myMessage.add(oscData[4]);
  oscP5.send(myMessage, myRemoteLocation);
    //--
  myMessage = new OscMessage("/isadora/22");  // click
  myMessage.add(oscData[5]);
  oscP5.send(myMessage, myRemoteLocation);
}








