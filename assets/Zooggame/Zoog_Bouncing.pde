class Zoog_Bouncing extends Zoog {
  Board board;
  State_Game state;
  Zoog_Bouncing(float x, float y, Board board, State_Game state) {
    super(x, y);
    this.board = board;
    this.state = state;
  }

  void move() {
    x += x_d * speed;
    y += y_d * speed;

    if ( x>width || x<0 ) x_d *= -1;    //Bounce SideWall

    if ( boardhit(board) )y_d *= -1;            //Bounce on Board
    if ( y-h<0 && state.count.count_hit>0) y_d *= -1;
  }
}