class Zoog_Crossing extends Zoog {
  int x_d = -1, y_d = 0;
  float speed = 3;
  Board board;

  Zoog_Crossing(float x, float y) {
    super(x, y);
    this.board = board;
  }

  void move() {
    x += x_d * speed;
  }
}
