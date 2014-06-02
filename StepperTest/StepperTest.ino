/* 
This is a test sketch for the Adafruit assembled Motor Shield for Arduino v2
It won't work with v1.x motor shields! Only for the v2's with built in PWM
control

For use with the Adafruit Motor Shield v2 
---->	http://www.adafruit.com/products/1438
*/


#include <Wire.h>
#include <Adafruit_MotorShield.h>
#include "utility/Adafruit_PWMServoDriver.h"


Adafruit_MotorShield AFMS = Adafruit_MotorShield(); 

Adafruit_StepperMotor *myMotorX = AFMS.getStepper(48, 1);
Adafruit_StepperMotor *myMotorY = AFMS.getStepper(48, 2);

void setup() {
  Serial.begin(9600);           // set up Serial library at 9600 bps
  Serial.println("Stepper test!");

  AFMS.begin();  // create with the default frequency 1.6KHz
  //AFMS.begin(1000);  // OR with a different frequency, say 1KHz
  
  myMotorX->setSpeed(5000);  // 10 rpm   
  myMotorY->setSpeed(5000);
}

void loop() {
    static int v = 0; 
  if ( Serial.available()) {
    char ch = Serial.read();
    switch(ch) { 
      case '0'...'9': 
        v = v * 10 + ch - '0';
        break;
      case 'q': // if it's x
        myMotorX->step(v, FORWARD, DOUBLE); 
        v = 0;
        break;
      case 'd':
       myMotorX->step(v, BACKWARD, DOUBLE); 
        v = 0;
        break;
      case 'z': // if it's x
        myMotorY->step(v, FORWARD, DOUBLE); 
        v = 0;
        break;
      case 's':
       myMotorY->step(v, BACKWARD, DOUBLE); 
        v = 0;
        break;
    }
  }
}
