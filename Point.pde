class Point {
float x;
float y;

  Point(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  boolean isEqual(float _x, float _y){
    return (x==_x) && (y==_y);
  }
  
}
