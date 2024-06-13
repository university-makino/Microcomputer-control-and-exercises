// writeFile
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

PFont myFont;
int usePin0 = 0;
int usePin1 = 1;
int usePin2 = 2;
String Label0 = "array0";
String Label1 = "array1";
String Label2 = "array2";
int[] array0 = new int[0];
int[] array1 = new int[0];
int[] array2 = new int[0];
int input0, input1, input2;
boolean isRecording = false;

// setup Method
void setup(){
    size(600, 250);
    arduino = new Arduino(this, "/dev/cu.usbserial-14P54810",57600);
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    input1 = arduino.analogRead(usePin1);
    input2 = arduino.analogRead(usePin2);
    // show analog input values
    fill(255);
    text( "A0 x = " + input0, 15, 30);
    text( "A1 y = " + input1, 15, 60);
    text( "A2 z = " + input2, 15, 90);
    // visualise analog input values
    noStroke();
    rect( 235, 10, (input0)/4, 20);
    rect(235,40,(input1)/4,20); 
    rect(235,70,(input2)/4,20); 
    stroke( 255, 0, 0);
    line( 235, 5, 235, 125);
    line( 490, 5, 490, 125);
    if( isRecording ){
        // If it’s Recording, use array to store data.  
        array0 = append( array0, input0); 
        array1 = append( array1, input1); 
        array2 = append( array2, input2); 
        // display it’s recording
        text( "Recording...", 40, 180);
        text( "Press any key to End Recording",40, 210);
        if(second()%2 ==1 ){
        fill(255,0,0);
        ellipse( 25, 170, 9,9);
        }
    } else {
        // If it’s not Recording, show how to use.
        text( "Press Esc key to Exit", 40, 180); 
        text( "Press any key to Record", 40, 210);
    }
}

void keyPressed() {
    if( isRecording ){
        // making contents of csv file 
        String[] lines = new String[array0.length +1 ];
        lines[0] = "Steps," + Label0 + ","+Label1+","+Label2;
        for (int i = 0; i < array0.length; i++) { 
            lines[i+1] = (i+1) + "," + array0[i] +"," + array1[i] + "," + array2[i];
        }
        // making filename  
        String filename = "Rec" + year();
        if( month() < 10 ){ filename += "0";}
        filename += month();
        if( day() < 10 ){ filename += "0";}
        filename += day() + " ";
        if( hour() < 10 ){ filename += "0";}
        filename += hour();
        if( minute() < 10 ){ filename += "0";}
        filename += minute();
        if( second() < 10 ){ filename += "0";}
        filename += second() + ".csv";
        saveStrings(filename, lines); 
        // Initializing
        array0 = expand(array0, 0); 
        array1 = expand(array1, 0); 
        array2 = expand(array2, 0); 
        isRecording = false;
    } else {
        // Switch on
        isRecording = true; 
    }
}
// write file
