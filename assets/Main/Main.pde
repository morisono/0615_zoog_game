// import ddf.minim.*;

// Minim minim;
// AudioPlayer player;
PImage bg1, bg2, bg3, bg4, bg5;
PFont font1, font2;
State state;

void setup() {
  size(800, 800);
  frameRate(120);
  // minim = new Minim(this);
  // player = minim.loadFile("../../sounds/bensound-buddy.mp3");
  // player.play();
  bg1 = loadImage("images/town.png"); // title
  bg2 = loadImage("images/city.png");   // tobe
  bg3 = loadImage("images/forest.png"); // nerae
  bg4 = loadImage("images/city.png"); // yokero
  bg5 = loadImage("images/mountain.png"); // hanekaese
  font1 = createFont("Comic Sans MS", 48, true);
  font2 = createFont("Yu Gothic", 48, true);
  textFont(font1);
  state = new State_Title(1);
}

void draw() {
  state = state.load();
}
