class State_Game_Tobe extends State {
  Zoog[] zoog;
  Human human;
  Time time;
  Count count;
  int stage;
  int t_all;
  int count_all;
  boolean gameclear, gameover;

  State_Game_Tobe(int stage, int count_all, int t_all) {
    // player.close();
    // player = minim.loadFile("../../sounds/bensound-clearday.mp3");
    this.stage = stage;
    this.count_all = count_all;
    this.t_all = t_all;
    this.zoog = new Zoog[count_all];
    for (int i=0; i<zoog.length; i++) {
      zoog[i] = new Zoog_Crossing( random(width, width*2), height*0.68 );
    }
    human = new Human();
    count = new Count(count_all);
    time  = new Time(t_all, t_state);
    gameclear = false;
    gameover  = false;
  }

  void update() {
    player.play();
    count.count_dead = 0;
    for (Zoog zg : zoog) {
      zg.move();
      if(human.hit(zg.x, zg.y, zg.w)) gameover = true;
    }
    for (Zoog i : zoog) {
      if ( !i.dead() ) {
        gameclear = false;
        break;
      }
      gameclear = true;
    }
    human.move();

    time  = new Time(t_all, t_state);
  }

  void display() {
    background(bg2);
    for (int i=0; i<zoog.length; i++)
      zoog[i].display();
    human.display();
    time.display();
  }

  State next() {
    if (gameclear) {player.close(); minim.stop(); return new State_End_Youwon(stage+1);}
    else if (gameover) {player.close(); return new State_End_Gameover("Collision", stage*1000+count.count_dead*100+time.t_remain*10);}
    else if ( time.t_remain<=0  ) {player.close(); return new State_End_Youwon(stage);}
    return this;
  }
}
