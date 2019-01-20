class Paddle {
  //position vector
  PVector p = new PVector();
  //diameter
  float d;
  //flags for moving left or right
  boolean left;
  boolean right;
  
  //set the speed
  int speed = 5;
  //set the yoffset
  Paddle(PVector p_, float d_){
    //Set the initial position and diameter
    p = p_;
    d = d_;
  }
  void update(){
    //If the flag is set, update that direction
    if(right || left){
      p.x = move();
    }
    if(right && p.x >= 750){
      p.x = 50;
    }
    if(left && p.x <= 0){
      p.x = 750;
    }
    this.draw();
  }
  
  float move(){
    //return the change in x based off of movement flags
    if(right){
      p.x += speed;
    } else if(left) {
      p.x -= speed;
    }
    return p.x;
  }

  void draw(){
    //Draw an arc using the CHORD parameter from theta past PI to theta shy of 2*PI
    //arc(p.x, p.y, d, d, );
    //Add the radius to the y position and subtract the y offset. 
    stroke(0);
    fill(0);
    ellipse(p.x, p.y, d,d);
  }
  
  void keyPressed(){
    //Set movement 'key' flags to true
    if(keyCode == 39){
      right = true;
    }
    if(keyCode == 37){
      left = true;
    }
    
  }
  
  void keyReleased(){
    //Set movement 'key' flags to false
    if(keyCode == 39){
      right = false;
    }
    if(keyCode == 37){
      left = false;
    }
  }
}
