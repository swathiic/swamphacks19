import controlP5.*;

ControlP5 cp5;
GameState gs;
int w, h;
boolean playing;
Button play;
Button word;
int dead = 1; 
int deathCount = 0;

Textlabel tb;
Textlabel tb2;
Textlabel tb3;
Textlabel y;
Textlabel o;
Textlabel s;
Textlabel hh;
Textfield text;
//Textlabel deff;

boolean yyy = false;
boolean ooo = false;
boolean sss = false;
boolean hhh = false;

int levell = 1;
int score = 0;

String textValue = "";
String def = "test";

String [] words;
String [] definitions;

void setup() {
  //set the size and renderer to P2D
  size(800, 800, P2D);
  //Call init()
  init();
  tb = cp5.addTextlabel("Score")
    .setText("Score: " + score)
    .setPosition(100, 50)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 20))
    ;
  tb2 = cp5.addTextlabel("Level")
    .setText("Level: " + levell)
    .setPosition(100, 70)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 20))
    ;
  tb3 = cp5.addTextlabel("Win")
    .setText("YOU WIN!!")
    .setPosition(200, 20)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 60))
    .hide();
  ;
  y = cp5.addTextlabel("cheat y")
    .setText("big ball cheat activated")
    .setPosition(600, 20)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 10))
    .hide();
  ;
  o = cp5.addTextlabel("cheat o")
    .setText("invincibility cheat activated")
    .setPosition(600, 40)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 10))
    .hide();
  ;
  s = cp5.addTextlabel("cheat s")
    .setText("fast cheat activated")
    .setPosition(600, 60)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 10))
    .hide();
  ;
  hh = cp5.addTextlabel("cheat h")
    .setText("slow cheat activated")
    .setPosition(600, 80)
    .setColorValue(0xffffff00)
    .setFont(createFont("Georgia", 10))
    .hide();
  ;

  
  //hehe
  PFont font = createFont("arial", 20);

  //cp5 = new ControlP5(this);

  text = cp5.addTextfield("word")
    .setPosition(250, 370)
    .setSize(200, 40)
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0))
    .setCaptionLabel("");
  ;

  //cp5.addBang("clear")
  // .setPosition(470, 370)
  // .setSize(80, 40)
  // .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  // ;
  textFont(font);
  words = ReadFromFile("words.txt");
  definitions = ReadFromFile("definition.txt");

  text.hide();
}

void init() {
  cp5 = new ControlP5(this);
  //set w, h, gs, play
  w = 800;
  h = 800;
  play = playButton();
  word = wordButton();
  word.hide();
  
  levell = 1;
  gs = new GameState(w, h, "49303.glsl");
  playing = false;
  dead = 1;
}

void draw() {
  //reset ground
  //ground(gs.fragment_shader);
  tb.setText("Score: " + score);
  tb2.setText("Level: " + levell);
  gs.fragment_shader.set("resolution", width, height);
  gs.fragment_shader.set("mouse", mouseX/(width*1.0), 1 - mouseY/(height*1.0));
  gs.fragment_shader.set("time", gs.time);
  filter(gs.fragment_shader);
  //if the game is playing, update and draw, otherwise just draw 
  if (playing) {
    gs.update();
    gs.draw();
    //update
  } else {
    gs.draw();
  }

  //if the ball position exceeds the window height, call init() (to reset)
  if (gs.ball.pos.y >= (800 - (gs.ball.diameter / 2))) {
    if (ooo) {
      gs.ball.velocity.y *= -1;
    } else {
      init();
      score = 0;
      levell = 1;
    }
  }
  //println(dead);
  if (dead%6 == 0 && dead!=0) {
    text("Definition:", 55, 125);
    text(definitions[deathCount], 55, 145);
    //println(def);
    word.show();
    playing = false;
    text.show();
  } else {
    word.hide();
    text.hide();
  }
}

Button playButton() {
  //Create a Button, return it.
  //Use createFont, ControlFont, and setFont 
  //Center the font by subtracting half of the size from the position
  Button b = cp5.addButton("toggle");
  b.setSize(600, 200);
  b.setPosition(100, 300);
  b.setCaptionLabel("PLAY");
  PFont pfont = createFont("Arial", 100); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont, 100);
  b.setFont(font);
  return b;
}

Button wordButton() {
  Button b = cp5.addButton("wtoggle");
  b.setSize(80, 40);
  b.setPosition(470, 370);
  b.setCaptionLabel("Check");
  PFont pfont = createFont("Arial", 10); // use true/false for smooth/no-smooth
  ControlFont font = new ControlFont(pfont, 10);
  b.setFont(font);
  return b;
}

void toggle() {
  //Flip the value of the boolean
  playing = !playing;
  //If the game is playing, hide the button, otherwise show it
  if (tb3.isVisible()) {
    levell = 1;
    tb3.hide();
    score = 0;
    tb2.show();
  }

  if (playing) {
    play.hide();
  } else {
    play.show();
  }

  //use the button's hide and show functions
}

void wtoggle() {
  println(text.getText());
  println(words[deathCount]);
  String temp = text.getText().toLowerCase();
  String temp1 = words[deathCount].toLowerCase();
  if(temp.equals(temp1)){
      playing=!playing;
      dead++;
      deathCount++;
      text.setText("");
  }
  else{
    text.setText("Try Again!");
  }

}

void keyPressed() {
  //call the GameState's keyPressed command
  gs.keyPressed();
  //press 'p' to pause/unpause (via toggle())
  if (keyCode == 80) {
    toggle();
  }
  if (keyCode == 13){
    println("here");
    wtoggle();
  }
  if (key == '`') saveFrame("screenshots/screenshot-####.png");

  //uncomment to advance thru levels without actually beating it
  if (key == '1') {
    for (int i = 0; i < gs.level.length; i++) {
      gs.level[i].alive = false;
    }
    score = 60 * levell;
  }

  if (key == '2') {
    yyy = !yyy;
    if (yyy)
      y.show();
    else
      y.hide(); 
  }

  if (key == '3') {
    ooo = !ooo;
    if (ooo)
      o.show();
    else
      o.hide();
  }
  if (key == '4') {
    sss = !sss;
    if (sss) {
      hhh = false;
      s.show();
      hh.hide();
    } else {
      s.hide();
    }
  }
  if (key == '5') {
    hhh = !hhh;
    if (hhh) {
      hh.show();
      sss = false;
      s.hide();
    } else
      hh.hide();
  }

}

void keyReleased() {
  //call the GameState's keyReleased command
  gs.keyReleased();
}

public void clear() {
  cp5.get(Textfield.class, "textValue").clear();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    //println("controlEvent: accessing a string from controller '"
    //  +theEvent.getName()+"': "
    //  +theEvent.getStringValue()
    //  );
  }
}


public void input(String theText) {
  // automatically receives results from controller input
  //println("a textfield event for controller 'input' : "+theText);
}

String[] ReadFromFile(String fileName) {
  String[] lines = loadStrings(fileName);
  return lines;
}
