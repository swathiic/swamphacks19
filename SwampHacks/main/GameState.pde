class GameState {
  //create a PShader (fragment shader) and PImage (texture)
  PShader fragment_shader;
  //create some helper variables (s,w,h)
  int w = 0;
  int h = 0;
  int s = 0;
  //time variable
  float time = 0.0;

  //Declare a: Ball, Paddle, Box[] walls, and Box[] level
  Ball ball = new Ball(400.0, 700.0, 25.0);
  Paddle paddle = new Paddle(new PVector(400.0, 835.0), 150.0);
  Box[] walls;
  Box[] level;

  GameState(int w_, int h_, String glsl){
    //set variables
    w = w_;
    h = h_;

    fragment_shader = loadShader(glsl);
    //create ball, paddle, walls, level
    walls = makeWalls();
    level = level0();
  }

  Box[] level0() {
    //Create a grid of boxes
    Box[] b = new Box[60];
    int c = 0;
    int y = 150;
    for(int i = 0; i < 6; i++){
      int x = 105;
      y += 60;
      for(int j = 0; j < 10; j++){
        b[c] = new Box(x, y, x + 50, y + 50, false);
        x += 60;
        c++;
      }
    }
    return b;
  }
  
  void update() {
    //update ball and paddle, call collisions, increase time, and draw
    ball.update();
    paddle.update();
    time += 0.01;
    draw();
  }
  
  void draw() {
    //draw shader, draw boxes, check/print score/win
    checkWin();
    boxArrDraw(walls);
    boxArrDraw(level);
  }

  Box[] makeWalls() {
    //Make 3 boxes (left, top, right) as walls
    Box[] b = new Box[3];
    b[0] = new Box(0, 0, 800, 100, true);
    b[1] = new Box(0, 100, 50, 800, true);
    b[2] = new Box(750, 50, 800, 800, true);
    return b;
  }

  void boxArrDraw(Box[] boxes) {
    //draw for each in an array of boxes
    for(int i = 0; i < boxes.length; i++){
      Box temp = boxes[i];
      if (temp.wall){
       temp.draw();
      } else {
        if(temp.alive){
          temp.draw();
        }
      }
    }
  }

  void checkWin() {
    //if there aren't any boxes left, print "You Win"
    if(levell <= 5){
      if(score / levell >= 60){
        text.hide();
        init();
        levell++;
        for(int i = 0; i < gs.level.length; i++){
           gs.level[i].lives = levell;
        }
      }
    if(levell > 5){
        tb2.hide();
        tb3.show();
        init();
        levell = 1;
        score = 0;
    }
    }
    //otherwise print the current score
  }
  void keyPressed() {
    //call the paddle's keyPressed command
    paddle.keyPressed();
  }
  void keyReleased() {
    //call the paddle's keyReleased command
    paddle.keyReleased();
  }
}
