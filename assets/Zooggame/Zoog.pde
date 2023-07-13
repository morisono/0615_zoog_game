abstract class Zoog {
  float x, y, w, h, eye;
  int x_d = ((int)random(2)*2-1), y_d = 1;
  float speed = 1;
  boolean eye_l_crushed = false, eye_r_crushed = false;

  Zoog(float x, float y) {
    this.x = x;
    this.y = y;
    w = 60; 
    h = 60; 
    eye = 16;
  }

  void display() {
    ellipseMode(RADIUS);
    rectMode(CENTER);
    stroke(0);
    fill(150);
    rect(x, y, w/3, h*5/3); // body
    stroke(0);
    fill(255);
    ellipse(x, y-h/2, w/2, h/2); // head
    noStroke();
    fill(eye_l_crushed?255:0);
    ellipse(x-w/3+1, y-h/2, eye/2, eye); // left eye
    fill(eye_r_crushed?255:0);
    ellipse(x+w/3-1, y-h/2, eye/2, eye); // right eye
    stroke(0);
    line(x-w/6, y+h*5/6, x-w/3, y+h); // left leg
    line(x+w/6, y+h*5/6, x+w/3, y+h); // right leg
  }
  
  void crushed(int mx, int my){
    if (sq(mx - (x-w/3+1))/((eye/2)*(eye/2)) + sq(my - (y-h/2))/(eye*eye) < 1) 
      eye_l_crushed = true;
    if (sq(mx - (x+w/3+1))/((eye/2)*(eye/2)) + sq(my - (y-h/2))/(eye*eye) < 1) 
      eye_r_crushed = true;  
  }

  boolean dead() {
      return (eye_l_crushed && eye_r_crushed);
  }

  boolean boardhit(Board board) {
    return (x>=board.board_x1 && x<=board.board_x2 && y>=board.board_y1 && y<=board.board_y2);
  }

  boolean overflow(Zoog zoog) {
    return (zoog.y-zoog.h>height && !dead());
  }

  abstract void move();
}