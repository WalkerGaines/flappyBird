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
  
  
  void display(){
    //println(y);
   //bottom pipe
   pushMatrix();
   translate(x-w/2,y+75);
   scale(1.75);
   image(pipe,0,0);
   popMatrix();
   
   //top pipe
   pushMatrix();
   translate(x,y-75);
   rotate(radians(180));

scale(1.75);
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
  
  void move(){
    x-=s;
  }
  
  void reset(){
    x=width+w/2;
    y=(int)random(200,600);
  }
  

  
  
}//end
