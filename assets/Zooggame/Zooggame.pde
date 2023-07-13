State state;
void setup() {  
  size(800, 800);
  frameRate(120);
  state = new State_Title(1);
}

void draw() {

  state = state.load();
  
  
}