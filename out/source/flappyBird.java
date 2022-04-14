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

public class flappyBird extends PApplet {

//Walker Gaines
Bird birb;
Pipe P;
Pipe P1;
ScoreBoard sb;
boolean up, menu, gameOver;
int i, test;
PFont num;
PImage BG,ground;



public void setup() {
  
  birb = new Bird();
  up=false;
  P = new Pipe();
  P1 = new Pipe(width+width/2+70,(int)random(200,600),70,2);
  sb = new ScoreBoard();

  menu = true;
  num = createFont("04B_19__.TTF", 128);
  BG = loadImage("backGround.png");
  ground = loadImage("ground.png");
  textFont(num);
  textAlign(CENTER);
  gameOver=false;
 
}//end

public void draw() {
  background(0);
  pushMatrix();

  scale(1.5f);
image(BG,0,0);

popMatrix();

  if (menu) {
    
    
  } else {
    

    
    P.display();
    P1.display();
    
  
    P.move();
    P1.move();
    
    birb.checkScore(P);
    birb.checkScore(P1);
    
    //movement
  birb.gravity();

    //gameOver
    if (birb.y+birb.h/2>height-birb.h-31) {//31 is the pxl height of the floor
      birb.Bstop();
      P.s=0;
      P1.s=0;
      
    }
  }
  
  birb.display();
  sb.display(); 
  //println(keyCode);
  image(ground,P.x-width-100,30);
  
 

}//end


  
public void keyPressed() {
  if (keyCode ==  32 && gameOver==false ) {
    menu=false;
    up=true;
    i=0;
  }

  

}
class Bird 
{
  int x, y, w, h, r;
  int birdC;
  float g;
  PImage cat;

  Bird() {
    x=width/2;
    y=height/2;
    w=45;
    h=35;
    birdC=0xffD8E525;
    g= 0;
    cat = loadImage("cat.png");
    r=0;
  }

  Bird(int Y, int W, int H, int C) {
    y=Y;
    w=W;
    h=H;
    birdC=C;
  }

  public void display() {


    pushMatrix();
    translate(x, y);






    rotate(radians(r));
    pushStyle();
    fill(birdC);

    popStyle();

    pushStyle();
    stroke(0);
    strokeWeight(5);
    noFill();
    //rect(0, 0, w+10, h);
    popStyle();

    image(cat, 0, 0);

    if (keyPressed && gameOver==false) {       
      r=-45;
    }



    popMatrix();
    noFill();
    //rect(x, y, w+10, h);
    
        if (collideWithTop(P) || collideWithTop(P1) || collideWithBottom(P) || collideWithBottom(P1)) {
      birb.Bstop();
      //println("yay");
      P.s=0;
      P1.s=0;
    }
  }

  public void gravity() {
    if (menu==false && g<=7) {
      y+=g;
      g+=.2f;
    } else {
      y+=g;
    }
    if (up) {
      g=-5;
      up=false;
    }
        if (r<80 ) {
      r+=2;
    }
  }

  public void checkScore(Pipe i) {
    if (i.x == width/2 || i.x == width/2-1) {
      sb.raise();
    }
  }

  public void Bstop() {
    if (birb.y+birb.h/2>height-birb.h-40) {
      g=0;
      gameOver=true;
    }
  }

  /*boolean collide(Bird c, Pipe r){
   if(c.x+c.w/2>=r.x-r.w+2 && c.x-c.w/2+35 <= r.x+r.w/2-2){
   
   if(c.y-c.h/2<=r.y-93 || c.y+c.h/2>=r.y+58){
   println("yay");
   gameOver=true;
   return true;
   
   
   }
   else{
   return false; 
   }
   }
   
   else{
   return false;
   }
   
   
   
   }
   */


    public boolean collideWithTop(Pipe p) {

    int x1, y1, x2, y2, x3, y3, x4, y4;
    int rx1, ry1, rx2, ry2, rx3, ry3, rx4, ry4;
    //bird
    //top left corner
    x1 = x;
    y1 = y;

    //top right corner
    x2 = w+10;
    y2 = 0;
    //println(x2);
    
    x2 = abs(PApplet.parseInt((x2*cos(radians(r)))-(y2*sin(radians(r)))))+x;
    y2 = PApplet.parseInt((y2*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
    
    //bottom left corner
    x3 = 0;
    y3 = h;
    
    x3 = PApplet.parseInt((x3*cos(radians(r)))-(y3*sin(radians(r))))+x;
    y3 = PApplet.parseInt((y3*cos(radians(r)))+(0*sin(radians(r))))+y;
    

    //bottom right corner
    x4 = w+10;
    y4 = h;
    
    x4 = PApplet.parseInt((x4*cos(radians(r)))-(y4*sin(radians(r))))+x;
    y4 = PApplet.parseInt((y4*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
    //println(x4,y4, " ", mouseX,mouseY);

    //pipe
    //top left pipe
    rx1 = p.x-p.w/2;
    ry1 = p.y-p.h/2-375;

    //top right pipe
    rx2 = p.x+p.w/2;
    ry2 = p.y-p.h/2-375;

    //bottom left pipe      
    rx3 = p.x-p.w/2;
    ry3 = p.y+p.h/2-375;

    //bottom right pipe      
    rx4 = p.x+p.w/2;
    ry4 = p.y+p.h/2-375;

/*
fill(255);
  beginShape();
    vertex(x1,y1);
    vertex(x2,y2);
    vertex(x4,y4);
    vertex(x3,y3);
  endShape(CLOSE);

  beginShape();
    vertex(rx1,ry1);
    vertex(rx2,ry2);
    vertex(rx4,ry4);
    vertex(rx3,ry3);
  endShape(CLOSE);
  */
  
  //bird in pipe
 if(x2>rx1 && x2<rx2 && y2<ry3 ||
    x1>rx1 && x1<rx2 && y1<ry3 ||
    x3>rx1 && x3<rx2 && y3<ry3 ||
    x4>rx1 && x4<rx2 && y4<ry3){
    return true;
    }

  //pipe in bird
if(rx3>x2 && rx3<x4 && ry3>y2 ||
   rx3>x1 && rx3<x2 && ry3>y1 ||
   rx4>x1 && rx4<x2 && ry4>y2 ||
   rx4>x3 && rx4<x2 && ry4>y1){
     return true;
   }


   return false;
    }   



  public boolean collideWithBottom(Pipe p) {

    int x1, y1, x2, y2, x3, y3, x4, y4;
    int rx1, ry1, rx2, ry2, rx3, ry3, rx4, ry4;
    //bird
    //top left corner
    x1 = x;
    y1 = y;

    //top right corner
    x2 = w+10;
    y2 = 0;
    //println(x2);
    
    x2 = abs(PApplet.parseInt((x2*cos(radians(r)))-(y2*sin(radians(r)))))+x;
    y2 = PApplet.parseInt((y2*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
    
    //bottom left corner
    x3 = 0;
    y3 = h;
    
    x3 = PApplet.parseInt((x3*cos(radians(r)))-(y3*sin(radians(r))))+x;
    y3 = PApplet.parseInt((y3*cos(radians(r)))+(0*sin(radians(r))))+y;
    

    //bottom right corner
    x4 = w+10;
    y4 = h;
    
    x4 = PApplet.parseInt((x4*cos(radians(r)))-(y4*sin(radians(r))))+x;
    y4 = PApplet.parseInt((y4*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
    //println(x4,y4, " ", mouseX,mouseY);

    //pipe
    //top left pipe
    rx1 = p.x-p.w/2;
    ry1 = p.y-p.h/2+375;

    //top right pipe
    rx2 = p.x+p.w/2;
    ry2 = p.y-p.h/2+375;

    //bottom left pipe      
    rx3 = p.x-p.w/2;
    ry3 = p.y+p.h/2+375;

    //bottom right pipe      
    rx4 = p.x+p.w/2;
    ry4 = p.y+p.h/2+375;

/*
fill(255);
  beginShape();
    vertex(x1,y1);
    vertex(x2,y2);
    vertex(x4,y4);
    vertex(x3,y3);
  endShape(CLOSE);

  beginShape();
    vertex(rx1,ry1);
    vertex(rx2,ry2);
    vertex(rx4,ry4);
    vertex(rx3,ry3);
  endShape(CLOSE);
  */
  
  //bird in pipe
 if(x2>rx1 && x2<rx2 && y4>ry2 ||
    x1>rx1 && x1<rx2 && y1>ry2 ||
    x3>rx1 && x3<rx2 && y3>ry2 ||
    x4>rx1 && x4<rx2 && y4>ry2){
    return true;
    }

  //pipe in bird
if(rx1<x2 && rx1>x4 && ry1<y4 ||
   rx1>x1 && rx1<x4 && ry1<y3 ||
   rx2>x1 && rx2<x3 && ry2<y3 ||
   rx2>x3 && rx2<x4 && ry2<y4){
     return true;
   }


   return false;
    }   

  }//end
class Pipe{
  int x,y,w,s,h;
  PImage pipe=loadImage("tart.png");

  
  Pipe(){
    y=height/2;
    w=70;
    x=width+w/2;
    s=2;
    h=600;
    
    
  }
  
  Pipe(int X, int Y,int W, int speed){
  y=Y;
  s=speed;
  w=W;
  x=X;
  h=600;
  ;
  }
  
  
  public void display(){
    //println(y);
   //bottom pipe
   pushMatrix();
   translate(x-w/2,y+75);
   scale(1.75f);
   image(pipe,0,0);
   popMatrix();
   
   //top pipe
   pushMatrix();
   translate(x,y-75);
   rotate(radians(180));

scale(1.75f);
image(pipe,-w/4-3,0);

   popMatrix();
    
    
    pushStyle();
    fill(0,255,0);
    //rectMode(CENTER);
    //noFill();
    //rect(x,y-375,w,600);
    //rect(x,y+375,w,600);
    
    popStyle();
    
   if(x+w/2 < 0){
     reset();
   }
  }
  
  public void move(){
    x-=s;
  }
  
  public void reset(){
    x=width+w/2;
    y=(int)random(200,600);
  }
  

  
  
}//end
class ScoreBoard{
  int x,y;
  int c;
  int score;
  ScoreBoard(){
    x=width/2;
    y=height/5;
    c=0xffFFFFFF;
  }
  
  ScoreBoard(int X, int Y, int  C){
    x=X;
    y=Y;
    c=C;
  }
  
  public void display(){
    fill(c);
    text(score, x,y);
  }
  
  public void raise(){
   score++; 
  }
}
  public void settings() {  size(480, 750,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flappyBird" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
