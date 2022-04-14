//Walker Gaines
Bird birb;
Pipe P;
Pipe P1;
ScoreBoard sb;
boolean up, menu, gameOver;
int i, test;
PFont num;
PImage BG,ground;



void setup() {
  size(480, 750,P2D);
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

void draw() {
  background(0);
  pushMatrix();

  scale(1.5);
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


  
void keyPressed() {
  if (keyCode ==  32 && gameOver==false ) {
    menu=false;
    up=true;
    i=0;
  }

  

}
