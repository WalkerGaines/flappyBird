//Walker Gaines
Bird birb;
Pipe P;
Pipe P1;
ArrayList<Rainbow> rainbows;
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
  rainbows = new ArrayList<Rainbow>();

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
    

    rainbows.add(new Rainbow(birb.x,birb.y));
    for( int i = rainbows.size()-1; i>=0;i--){
      Rainbow quick=rainbows.get(i);
      quick.display();
      quick.move();
        if(quick.x<0){
          rainbows.remove(quick);
          
        }
    }
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
