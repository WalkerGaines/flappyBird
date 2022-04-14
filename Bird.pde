class Bird 
{
  int x, y, w, h, r;
  color birdC;
  float g;
  PImage cat;

  Bird() {
    x=width/2;
    y=height/2;
    w=45;
    h=35;
    birdC=#D8E525;
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

  void display() {


    pushMatrix();
    translate(x, y);



    if (r<80 ) {
      r+=2;
    }


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
    rect(x, y, w+10, h);
    
        if (collideWithTop(P) || collideWithTop(P1) ) {
      birb.Bstop();
      //println("yay");
      P.s=0;
      P1.s=0;
    }
  }

  void gravity() {
    if (menu==false && g<=7) {
      y+=g;
      g+=.2;
    } else {
      y+=g;
    }
    if (up) {
      g=-5;
      up=false;
    }
  }

  void checkScore(Pipe i) {
    if (i.x == width/2 || i.x == width/2-1) {
      sb.raise();
    }
  }

  void Bstop() {
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


    boolean collideWithTop(Pipe p) {

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
    
    x2 = abs(int((x2*cos(radians(r)))-(y2*sin(radians(r)))))+x;
    y2 = int((y2*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
    
    //bottom left corner
    x3 = 0;
    y3 = h;
    
    x3 = int((x3*cos(radians(r)))-(y3*sin(radians(r))))+x;
    y3 = int((y3*cos(radians(r)))+(0*sin(radians(r))))+y;
    

    //bottom right corner
    x4 = w+10;
    y4 = h;
    
    x4 = int((x4*cos(radians(r)))-(y4*sin(radians(r))))+x;
    y4 = int((y4*cos(radians(r)))+((w+10)*sin(radians(r))))+y;
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
  
  //bird in pipe
 if(x2>rx1 && x2<rx2 && y2<ry3 ||
    x1>rx1 && x1<rx2 && y1<ry3 ||
    x3>rx1 && x3<rx2 && y3<ry3 ||
    x4>rx1 && x4<rx2 && y4<ry3){
    return true;
    }

  //pipe in bird
if(rx3>x2 && rx3<)


   return false;
    }   



  boolean collideWithBottom(Pipe p) {

    int x1, y1, x2, y2, x3, y3, x4, y4;
    int rx1, ry1, rx2, ry2, rx3, ry3, rx4, ry4;
    //bird
    //top left corner
    x1 = x;
    y1 = y;

    //top right corner
    x2 = x+w+10;
    y2 = y;

    //bottom left corner
    x3 = x;
    y3 = y+h;

    //bottom right corner
    x4 = x+w+10;
    y4 = y+h;

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
    
    //strokeWeight(8);
    //quad(x1,y1,x2,y2,x4,y4,x3,y3);
    if (x1<rx4 &&
      x4>rx1 &&
      y1<ry4 &&
      y4>ry1 &&
      
      x2>rx3 &&
      x3<rx2 &&
      y2 <ry3 &&
      y3>ry2
      ) {                            
      return true;
    } else {
      return false;
    }
  }
}//end
