//simplifies the unnecessarily complex blend command; image, x, y, width, height, center/corner

void blendImage(PImage bI, int pX, int pY, String b, boolean center) {
  String[] blendModes = { "BLEND", "ADD", "SUBTRACT", "LIGHTEST", "DARKEST", "DIFFERENCE", "EXCLUSION", "MULTIPLY", "SCREEN", "OVERLAY", "HARD_LIGHT", "SOFT_LIGHT", "DODGE", "BURN" };
  int[] blendModeCodes = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 };
  for(int i=0;i<blendModes.length;i++) {
    if(b==blendModes[i]) {
      int qX,qY;
      if(center) {
        qX=pX-(bI.width/2);
        qY=pY-(bI.height/2);
      } else {
        qX=pX;
        qY=pY;
      }
      blend(bI,0,0,bI.width,bI.height,qX,qY,bI.width,bI.height,blendModeCodes[i]);
    }
  }
}

//-------------------------------

//Tween movement.  start, end, ease (more = slower).
float tween(float v1, float v2, float e) {
  v1 += (v2-v1)/e;
  return v1;
}

//-------------------------------

//2D Hit Detect.  Assumes center.  x,y,w,h of object 1, x,y,w,h, of object 2.
boolean hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  w1 /= 2;
  h1 /= 2;
  w2 /= 2;
  h2 /= 2; 
  if(x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
    return true;
  } 
  else {
    return false;
  }
}

//-------------------------------

//Easy randomizer.  range,threshold
boolean rollDice(float v1, float v2) {
  float rollDiceNum;
  rollDiceNum = random(v1);
  if(rollDiceNum<v2) {
    return true;
  }
  else {
    return false;
  }
}

//---   END   ---

