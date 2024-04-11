import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
color bgColor = color(0);

void setup(){
    size(250, 150);
    println(Arduino.list());
    arduino = new Arduino(
    this, Arduino.list()[2], 57600);
}

void draw(){
    background(bgColor);
    bgColor = color(255, 0, 0);
}