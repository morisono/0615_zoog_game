class State_Pause extends State{
  int stage;
  State_Pause(int stage){
      this.stage = stage;
  }
  
  void update() {/* do nothing */
  }
  
  void display() {
    background(255);
  }

  State next(){
    if(keyPressed && key == ' ') {
      return new State_Title(stage);
    }
    return this;
  }
}
