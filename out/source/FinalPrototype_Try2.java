import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FinalPrototype_Try2 extends PApplet {



Lesson[] lessons;

int white = color(255, 255, 255), 
    black = color(0, 0, 0), 
    cyan = color(0, 174, 239), 
    magenta = color(236, 0, 140), 
    yellow = color(255, 242, 0), 
    red = color(255, 0, 0), 
    green = color(0, 255, 0), 
    blue = color(0, 0, 255), 
    c1 = color(198, 33, 39), // reddish
    c2 = color(2, 237, 64), // greenish
    c3 = color(33, 122, 198); // bluish

int lessonCount;
int globalLesson;           // to store which lesson is currently SELECTED not hovered
int globalState;        // 0 = homepage, 1 = construct, 2 = example
float[] sidebarWidth, mainWidth, secondaryWidth;
float marginTop, marginBottom, marginLeft, marginRight;
float effectiveWidth, effectiveHeight;

public void setup() {
   

    lessonCount = 6;
    globalState = 0;

    marginTop = 48;
    marginBottom = 48;
    marginLeft = 0;
    marginRight = 0;
    effectiveWidth = (width-marginRight-marginLeft);
    effectiveHeight = (height-marginTop-marginBottom);

    //define the width for three states: 0: homepage, 1: construct viz, 2: example open
    sidebarWidth = new float[]{ 1 * effectiveWidth/6, 1 * effectiveWidth/6, 1 * effectiveWidth/6 };
    mainWidth = new float[]{ 3 * effectiveWidth/6, 5 * effectiveWidth/6, 5 * effectiveWidth/6 };
    secondaryWidth = new float[]{ 2 * effectiveWidth/6, 0 * effectiveWidth/6, 0 * effectiveWidth/6 };

    //lessons[0] = new Lesson(0);
    
    lessons = new Lesson[lessonCount];
    
    for (int i=0; i<lessonCount; i++) {
        lessons[i] = new Lesson(i);
    }
}

public void draw() {
    background(255, 247, 0);
    for (int i=0; i<lessonCount; i++) {
        lessons[i].update();
        lessons[i].display();
    }
}

public void mouseClicked() {
    for (int i=0; i<lessonCount; i++) {
        if(lessons[i].checkHover()){
            lessons[i].onClick();
            lessons[i].selectedCheck = true;
            globalLesson = i;
        } else {
            lessons[i].selectedCheck = false;            
        }
    }
}

public void rect(PVector p, float w, float h) {
    rect(p.x, p.y, w, h);
}

class Element{
    PVector position;
    float w, h;
    int paddingLeft, paddingRight, paddingTop, paddingBottom;
    int hoverColor, mainColor, clickedColor;    
    boolean hoverCheck, selectedCheck;
    
    Element(){
        
        hoverCheck = false;
        selectedCheck = false;
    }
    
    public boolean checkHover(){
            if( (mouseX > position.x) && (mouseX < position.x + w) && (mouseY > position.y) && (mouseY < position.y + h) ){
                return true;
            }        
        return false;
    }
    
    public void onHover(){
        if(!selectedCheck) fill(hoverColor);
    }
    
    public void onClick(){                                                      // call this from global click event - mouseClicked(){}
        
            //fill(clickedColor);  
    }
    
    public void update(){
        hoverCheck = checkHover();
    }
    
    public void display(){
        fill(mainColor);
        println(selectedCheck);
        println(hoverCheck);
        if(hoverCheck) {
            onHover();
        }
        if(selectedCheck){
            fill(clickedColor);   
        }
        rect(position, w, h);
    }
    
}

class Example extends Element{
    Example(){
    
    }
}

class Lesson extends Element{
    int index;
    
    Lesson(int n){          
        index = n;        
        
        position = new PVector(sidebarWidth[globalState], 1.0f * index * effectiveHeight/lessonCount);
        
        paddingLeft = 0;
        paddingRight = 0;
        paddingTop = 5;
        paddingBottom = 5;
        
        w = mainWidth[globalState] - paddingLeft - paddingRight;
        h = (effectiveHeight/lessonCount) - paddingTop - paddingBottom;
        
        mainColor = color(255, 255, 255);
        hoverColor = color(255, 200, 200);
        clickedColor = color(0, 0, 255);   
    }
    
    public boolean checkHover(){
            if( (mouseX > position.x) && (mouseX < position.x + w) && (mouseY > position.y) && (mouseY < position.y + h) ){
                return true;
            }        
        return false;
    }
    
    public void onHover(){
        fill(hoverColor);
    }
    
    public void onClick(){                                                      // call this from global click event - mouseClicked(){}
        if(hoverCheck){
            selectedCheck = true;                                        // consider selectedCheck =! selectedCheck to toggle instead of always true
        } else {
            selectedCheck = false;
        }
    }
    
    public void update(){
        hoverCheck = checkHover();
    }
    
    public void display(){
        fill(mainColor);
        if(hoverCheck) {
            onHover();
        }
        rect(position, w, h);
    }
}
    public void settings() {  size(640, 480, P3D); }
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "FinalPrototype_Try2" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
