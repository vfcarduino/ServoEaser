//
// ServoEaserTest2.pde  --more complex example of using ServoEaser 
//                        this time with move lists
//
// 2011, TeamPneumo, Tod E. Kurt, http://todbot.com/blog/
//
//

#include <Servo.h>
#include "ServoEaser.h"

const int ledPin   = 13; 
const int servoPin = 7;

int servoFrameMillis = 20;  // minimum time between servo updates

Servo servo1; 
ServoEaser servoEaser;

// configurable list of servo moves
int myServoMovesCount0 = 9;
ServoMove myServoMoves0[] = {
// angle, duration
  { 10, 1500},
  {170, 1500},
  { 10, 1300},
  {170, 1300},
  { 90, 2000},
  { 90, 2000},  // wait
  {135, 3000},
  { 45, 3000},
  {135, 1000},
};

int myServoMovesCount1 = 7;
ServoMove myServoMoves1[] = {
// angle, duration
  { 90,  12000},
  { 85,  1000},
  { 95,  1000},
  { 80,  1000},
  { 100, 1000},
  { 70,  1000},
  { 110, 1000},
};
int myServoMovesCount = myServoMovesCount1;
ServoMove* myServoMoves = myServoMoves1;

// our replacement easing function
// from Easing::linearTween()
float linearTween (float t, float b, float c, float d) {
	return c*t/d + b;
}

//
void setup()
{
  Serial.begin(19200);
  Serial.println("ServoEasingTest2");


  //servo1.attach( servoPin );
  servo1.attach( servoPin, 700,2300 );
  
  //servoEaser.setMinMaxMicroseconds(600,2400);
  //servoEaser.useMicroSeconds(true);

  servoEaser.begin( servo1, servoFrameMillis, 90);

  // use my own easing function
  servoEaser.setEasingFunc( linearTween );

  // start playing a moves list on a particular servo
  servoEaser.play( myServoMoves, myServoMovesCount );
}

//
void loop()
{
  servoEaser.update();
}


