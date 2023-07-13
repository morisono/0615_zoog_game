class State_Game_Hanekaese extends State {
  Zoog[] zoog;
  Board board;
  Time time;
  Count count;
  int stage;
  int t_all;
  int count_all;
  boolean gameclear, gameover;

  State_Game_Hanekaese(int stage, int count_all, int t_all) {
    // player.close();
    // player = minim.loadFile("../../sounds/bensound-funkyelement.mp3");
    this.stage = stage;
    this.count_all = count_all;
    this.t_all = t_all;
    this.zoog = new Zoog[count_all];
    board = new Board();
    zoog[0] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0));
    for (int i=1; i<zoog.length; i++) {
      zoog[i] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0));
    }
    count = new Count(count_all);
    time  = new Time(t_all, t_state);
    gameclear = false;
    gameover  = false;
  }

  void update() {
    player.play();
    count.count_dead = 0;
    for (int i=0; i<zoog.length; i++) {
      zoog[i].move();
      if (zoog[i].dead()) count.count_dead++;
      if (mousePressed) zoog[i].crushed(mouseX, mouseY);
      if ( mousePressed && zoog[i].eye_l_crushed && zoog[i].eye_r_crushed ) {
        zoog[i].x_d = 0;
      }
      if ( !mousePressed ) zoog[i].speed = 1;
      if (zoog[i].overflow(zoog[i])) gameover = true;
      if (board.hit(zoog[i].x, zoog[i].y+ zoog[i].h)) {
        t_all += 3;
        count.count_hit++;
        zoog[i].eye_l_crushed = true;
        zoog[i].eye_r_crushed = true;
        zoog[i].boardhit();
      }
    }

    for (int i=0; i<zoog.length; i++) {
      if ( !zoog[i].dead() ) {
        gameclear = false;
        break;
      }
      gameclear = true;
    }
    board.follow_x();
    time  = new Time(t_all, t_state);
  }

  void display() {
    background(bg5);
    board.display();
    for (int i=0; i<zoog.length; i++)
      zoog[i].display();
    count.display();
    time.display();
  }

  State next() {
    if (gameclear) { player.close(); return new State_End_Youwon(stage+1);}
    else if (gameover) { player.close(); return new State_End_Gameover("Fallen Out", stage*1000+count.count_dead*100+time.t_remain*10);}
    else if ( time.t_remain<=0  ) { player.close(); return new State_End_Gameover("Times up", stage*1000+count.count_dead*100+time.t_remain*10);}
    return this;
  }
}
