class State_Game_Nerae extends State {
  Zoog[] zoog;
  Board board;
  Sight sight;
  Time time;
  Count count;
  int stage;
  int t_all;
  int count_all;
  boolean gameclear, gameover;

  State_Game_Nerae(int stage, int count_all, int t_all) {
    player.close();
    player = minim.loadFile("../../sounds/bensound-epic.mp3");
    this.stage = stage;
    this.count_all = count_all;
    this.t_all = t_all;
    this.zoog = new Zoog[count_all];
    this.sight = new Sight();
    board = new Board();
    zoog[0] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0));
    for (int i=1; i<zoog.length; i++) {
      zoog[i] = new Zoog_Bouncing( (int)random(width), (int)random(-height, 0) % (zoog[i-1].y*100));
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
      if( mousePressed && zoog[i].eye_l_crushed && zoog[i].eye_r_crushed )zoog[i].x_d = 0;
      if (zoog[i].overflow(zoog[i])) gameover = true;
    }
    for (int i=0; i<zoog.length; i++) {
      if ( !zoog[i].dead() ) {
        gameclear = false;
        break;
      }
      gameclear = true;
    }
    time  = new Time(t_all, t_state);
  }

  void display() {
    background(bg3);
    for (int i=0; i<zoog.length; i++)
      zoog[i].display();
    sight.display();
    time.display();
  }

  State next() {
    if (gameclear) { player.close(); return new State_End_Youwon(stage);}
    else if (gameover) {player.close(); return new State_End_Gameover("Fallen Out", stage*1000+count.count_dead*100+time.t_remain*10);}
    else if ( time.t_remain<=0  ) {player.close(); return new State_End_Gameover("Times up", stage*1000+count.count_dead*100+time.t_remain*10);}
    return this;
  }
}
