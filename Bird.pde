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
        if (r<80 ) {
      r+=2;
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
   */
   
   
   }
   


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
  
  PVector[] square1 = {
  new PVector(x1, y1),
  new PVector(x2, y2),
  new PVector(x3, y3),
  new PVector(x4, y4)
};
PVector[] square2 = {
  new PVector(rx1, ry1),
  new PVector(rx2, ry2),
  new PVector(rx3, ry3),
  new PVector(rx4, ry4)
};
if(polypoly(sqaure1,square2)){
  return true;
}
    }

// POLYGON/POLYGON
boolean polyPoly(PVector[] p1, PVector[] p2) {
  
  // go through each of the vertices, plus the next vertex in the list
  int next = 0;
  for (int current=0; current<p1.length; current++) {
    
    // get next vertex in list
    // if we’ve hit the end, wrap around to 0
    next = current+1;
    if (next == p1.length) next = 0;
    
    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = p1[current];    // c for “current”
    PVector vn = p1[next];       // n for “next”
    
    // now we can use these two points (a line) to compare to the
    // other polygon’s vertices using polyLine()
    boolean collision = polyLine(p2, vc.x,vc.y,vn.x,vn.y);
    if (collision) return true;
    
    // optional: check if the 2nd polygon is INSIDE the first
    collision = polyPoint(p1, p2[0].x, p2[0].y);
    if (collision) return true;
  }
  
  return false;
}


// POLYGON/LINE
boolean polyLine(PVector[] vertices, float x1, float y1, float x2, float y2) {

  // go through each of the vertices, plus the next vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we’ve hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // extract X/Y coordinates from each
    float x3 = vertices[current].x;
    float y3 = vertices[current].y;
    float x4 = vertices[next].x;
    float y4 = vertices[next].y;

    // do a Line/Line comparison
    // if true, return ‘true’ immediately and stop testing (faster)
    boolean hit = lineLine(x1, y1, x2, y2, x3, y3, x4, y4);
    if (hit) {
      return true;
    }
  }

  // never got a hit
  return false;
}


// LINE/LINE
boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the direction of the lines
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
    return true;
  }
  return false;
}


// POLYGON/POINT
// used only to check if the second polygon is INSIDE the first
boolean polyPoint(PVector[] vertices, float px, float py) {
  boolean collision = false;
  
  // go through each of the vertices, plus the next vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {
    
    // get next vertex in list
    // if we’ve hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;
    
    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for “current”
    PVector vn = vertices[next];       // n for “next”
    
    // compare position, flip ‘collision’ variable back and forth
    if ( ((vc.y > py && vn.y < py) || (vc.y < py && vn.y > py)) &&
         (px < (vn.x-vc.x) * (py-vc.y) / (vn.y-vc.y) + vc.x) ) {
            collision = !collision;
    }
  }
  return collision;  
}
    
  //bird in pipe
 /*if(x2>rx1 && x2<rx2 && y2<ry3 ||
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
*/


  boolean collideWithBottom(Pipe p) {

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
*/
  }
  
  //end
