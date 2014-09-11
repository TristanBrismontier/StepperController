int rad = 200;
int x = 399;
int y = 201;

int cx = 800;
int cy = 201;

float a = 0.02;

boolean xturn = true;

void setup(){
size(1750,1000);
frameRate(100);

}

void draw() {

  if( x == cx && y ==cy){
  compute();
  }else{
    
    if(xturn){
      moveX();
    }else{
      moveY();
    }
    xturn = !xturn;
  }
  println(cx + " "+cy);
  println( " x: " + x + " y:  " +y);
  point(x,y);
}

void moveX(){
  if(x==cx)return;
  x = ((x-cx)<0)?x+1:x-1;
}

void moveY(){
  if(y==cy)return;
  y = ((y-cy)<0)?y+1:y-1;
}

void compute(){
  a += 0.01; 
  
  float cfx = cos(a)*rad*2 + rad*2;
  float cfy = sin(a)*rad + rad;
  
  cx = (int) cfx;
  cy = (int) cfy;  

}
  
  
