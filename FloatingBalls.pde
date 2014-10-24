/*below is the Live2Processing stuff */
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float amp;
int OSCnote;
int OSCvelocity;
int DrumBass = 20; //match this to the bassdrum cc#
int DrumSnare = 21; //match this to the snare cc#
//End of L2P Setup ___________________________________

/*this is the midi control stuff*/
import themidibus.*;
float cc[] = new float [256];
MidiBus myBus;
//End of MIDIBus Setup ______________________________

int total = 100; //total number of balls i want live
//int r = 1; //this is the divisable number used in draw()
Ball [] myball; //this is from a class i've created

//PImage stuff
PImage OEtextLight;
PImage OEtextDark;

//Display Ratio
int screenWidth = 1024;
int screenHeight = 768;
//___________________________________________________

void setup() {
  size(screenWidth, screenHeight, P2D); // size of display window
  colorMode(HSB, 360, 100, 100); // switches to HSB over RGB
  smooth(8); // makes things look smoother
  
  OEtextLight = loadImage("OrbitEyesText_Light.png");
  OEtextDark = loadImage("OrbitEyesText_Dark.png");

  oscP5 = new OscP5(this, 8080); // make sure this is in SETUP()

  myball = new Ball[total]; // calls the class and redefines it

  for (int i = 0; i < total; i ++) {
    myball[i] = new Ball();
  } //calls the run() function for every ball
}

//initiallize the object of variable
///// END OF SETUP ___________________________________

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/drumMidiNote1") == true) {
    OSCnote = theOscMessage.get(0).intValue();
    println("ccNote:" + OSCnote);
  }
  if (theOscMessage.checkAddrPattern("/drumMidiVelocity1") == true) {
    OSCvelocity = theOscMessage.get(0).intValue();
    println("ccVelocity:" + OSCvelocity);
  }
  if (theOscMessage.checkAddrPattern("/drumAmpL1") == true) {
    amp = theOscMessage.get(0).floatValue();
    println("Amplitude:" + amp);
  }
}
///// END OF OSC_EVENT_______________________________



void draw() {
  noStroke();
  fill(0, 0, 75, 75); //this is the background with transparency for tail trails
  rectMode(LEFT);
  rect(0, 0, displayWidth, displayHeight); // background rectangle
  
  imageMode(CENTER);
  image(OEtextDark, width/2, height/2);

  for (int i = 0; i < 100; i ++) {
    if (OSCnote == DrumSnare && i%4==0) {
      fill(0, 0, 85);
      ellipse(myball[i].location().x, myball[i].location().y, amp, amp*.25);
      
    }
    myball[i].run(); //my functionality is void run()
    if (OSCnote == DrumBass && i%3==0) {
      //rectMode(CENTER);
      fill(0, 0, 90);
      ellipse(myball[i].location().x, myball[i].location().y, amp, amp);
    }
  }

  //  myball[0].location=new PVector (width/2, height/2);
  //  myball[0].velocity=new PVector (0, 0);
}

