class State_Game extends State {
  Zoog[] zoog;
  Board board;
  Sight sight;
  Time time;
  Count count;
  int stage;
  int t_all;
  int count_all;
  boolean gameclear, gameover;

  State_Game(int stage, int count_all, int t_all) {
    this.stage = stage;
    this.count_all = count_all;
    this.t_all = t_all;
    this.zoog = new Zoog[count_all]; 
    this.sight = new Sight();
    board = new Board();
    zoog[0] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0), board, this);
    for (int i=1; i<zoog.length; i++) {
      zoog[i] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0) % (zoog[i-1].y*100), board, this);
      //if(i%count_all == 0)
      //zoog[i] = new Zoog_Jiggling( (int)random(width), (int)random(-height+1,0), board );
    }
    count = new Count(count_all);
    time  = new Time(t_all, t_state);
    gameclear = false;
    gameover  = false;
  }

  void update() {
    count.count_dead = 0;
    for (int i=0; i<zoog.length; i++) {
      zoog[i].move();
      if (zoog[i].dead()) count.count_dead++; 
      if (mousePressed) zoog[i].crushed(mouseX, mouseY);
      if( mousePressed && zoog[i].eye_l_crushed||zoog[i].eye_r_crushed ) zoog[i].speed = 0.4;
      if( !mousePressed ) zoog[i].speed = 1;
      if (zoog[i].overflow(zoog[i])) gameover = true;
      if (zoog[i].boardhit(board)) {
         t_all += 5;
         count.count_hit++;
         zoog[i].eye_l_crushed = true;
         zoog[i].eye_r_crushed = true;
        //if(i%count_all==0)gameover = true;
      }
    }
    for (int i=0; i<zoog.length; i++) {
      if ( !zoog[i].dead() ) {
        gameclear = false; 
        break;
      } 
      gameclear = true;
    }
    board.move();
    time  = new Time(t_all, t_state);
  }

  void display() {
    background(#808080);
    board.display();
    for (int i=0; i<zoog.length; i++)
      zoog[i].display();
    sight.display();
    count.display();
    time.display();
  }
  
  State next() {
    if (gameclear) return new State_End_Youwon(stage);
    else if (gameover) return new State_End_Gameover("Fallen Out", stage*1000+count.count_dead*100+time.t_remain*10);
    else if ( time.t_remain<=0  ) return new State_End_Gameover("Times up", stage*1000+count.count_dead*100+time.t_remain*10);
    return this;
  }
}