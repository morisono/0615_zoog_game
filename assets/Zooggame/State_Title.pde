class State_Title extends State {
  Zoog[] zoog;
  int stage;

  State_Title(int stage) {
    this.stage = stage;
    this.zoog = new Zoog[stage];
    for (int i=0; i<zoog.length; i++)
      zoog[i] = new Zoog_Stopping(width * 0.5 + (i+1)/2*80*pow(-1, i%2), height * 0.5);
  }
  void update() {/* do nothing */
  }
  void display() {
    background(255);
    fill(0);
    textSize(36);
    textAlign(CENTER, CENTER);
    text("Zooggame", width * 0.5, height * 0.3);
    textSize(20);
    text("STAGE "+stage, width * 0.5, height * 0.6);
    text("Press [SPACE] to start", width * 0.5, height * 0.7);
    for (int i=0; i<zoog.length; i++) zoog[i].display();
  }

  State next() {
    if (keyPressed && key == ' ') {
      return new State_Game(stage, stage*6, 20);
    }
    return this;
  }
}