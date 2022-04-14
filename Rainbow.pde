class Rainbow{
    int x, y;

Rainbow(int X, int Y){
x=X;
y=Y;
}

    void display(){
        strokeWeight(0);
    fill(#FF0000);
         rect(x,y+30,10,10);
    fill(#FF9900);
        rect(x,y+20,10,10);
    fill(#FFFF00);
        rect(x,y+10,10,10);
    fill(#33FF00);
        rect(x,y+0,10,10);
    fill(#0099FF);
        rect(x,y-10,10,10);
    fill(#6633FF);
        rect(x,y-20,10,10);
    }

    void move(){
        x-=2;
    }
}