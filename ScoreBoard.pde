class ScoreBoard{
  int x,y;
  color c;
  int score;
  ScoreBoard(){
    x=width/2;
    y=height/5;
    c=#FFFFFF;
  }
  
  ScoreBoard(int X, int Y, color  C){
    x=X;
    y=Y;
    c=C;
  }
  
  void display(){
    fill(c);
    text(score, x,y);
  }
  
  void raise(){
   score++; 
  }
}
