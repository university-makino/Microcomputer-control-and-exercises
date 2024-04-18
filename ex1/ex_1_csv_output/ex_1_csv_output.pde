// writeFile
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

PFont myFont;
int usePin0 = 0;
String Label0 = "array0";
int[] array0 = new int[0];

int input0;
boolean isRecording = false;
// setup Method
void setup(){
    size(600, 250);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P54810"
    );
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}

void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    // show analog input values
    fill(255);
    text("Ain - 0 = " + input0, 15, 30);
    // visualise analog input values
    noStroke();
    rect(235, 10, (input0) / 4, 20);
    stroke(255, 0, 0);
    line(235, 5, 235, 125);
    line(490, 5, 490, 125);
    if (isRecording){
        // If it’s Recording, use array to storedata.
        array0 = append(array0, input0);
        // display it’s recording
        text("Recording...", 40, 180);
        text("Press any key to End Recording",40, 210);
        if (second() % 2 == 1){
            fill(255, 0, 0);
            ellipse(25, 170, 9, 9);
        }
    } else {
        // If it’s not Recording, show how to use.
        text( "Press Esc key to Exit", 40, 180);
        text( "Press any key to Record", 40, 210);
    }
}

void keyPressed(){
    if (isRecording){

        // making contents of csv ﬁle
        String[] lines = new String[array0.length + 1];
        lines[0] = "Steps," + Label0;
        for (int i = 0; i < array0.length; i++){
            lines[i + 1] = (i + 1) + "," + array0[i];
        }

        // making ﬁlename
        String ﬁlename = "Rec " + year();
        if (month() < 10){
            ﬁlename += "0";
        }
        ﬁlename += month();
        
        if (day() < 10){
            ﬁlename += "0";
        }
        ﬁlename += day() + " ";

        if (hour() < 10){
            ﬁlename += "0";
        }
        ﬁlename += hour();

        if (minute() < 10){
            ﬁlename += "0";
        }
        ﬁlename += minute();

        if (second() < 10){
            ﬁlename += "0";
        }
        ﬁlename += second() + ".csv";

        // write ﬁle
        saveStrings(ﬁlename, lines);

        // Initializing
        array0 = expand(array0, 0);
        isRecording = false;
    } else {
        // Switch on
        isRecording = true;
    }
}
