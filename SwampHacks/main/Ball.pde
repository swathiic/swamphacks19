class Ball {
  //Declare position, velocity, diameter, speed, score
  //float position;
  PVector pos = new PVector();
  PVector velocity = new PVector();
  float diameter;
  
  Ball(float x_, float y_, float d_) {
    //Initialize position, velocity, diameter, speed
    diameter = d_;
    pos.x = x_;
    pos.y = y_;
    velocity.x = 0;
    if(sss){
      velocity.y = 8;
    }else if (hhh){
      velocity.y = 2;
    } else {
      velocity.y = 4;
    }
  }

  void update() {
    //update the position
    pos.x += velocity.x;
    pos.y += velocity.y;
    if(sss){
      velocity.setMag(8);
    }else if (hhh){
      velocity.setMag(2);
    } else {
      velocity.setMag(4);
    }
    collide_circle(gs.paddle);
    for (int i = 0; i < 3; i++) {
      collide_box(gs.walls[i]);
    }
    for (int i = 0; i < 60; i++) {
      collide_box(gs.level[i]);
    }

    this.draw();
    if(yyy){
      diameter = 50;
    } else {
      diameter = 25;
    }
  }

  void collide_circle(Paddle pad) {
    //Check that the distance between the centers 
    //  is less than the sum of the radii.
    float dist = PVector.dist(pad.p, pos);
    float sum = (pad.d / 2) + (diameter / 2);
    if (dist < sum) {
      //Calculate the reflection vector R where n is the normal
      PVector n = new PVector(pos.x - pad.p.x, pos.y - pad.p.y);
      n.setMag(1);
      velocity =  velocity.sub(n.mult(n.dot(velocity) * 2));
    }
    //if so
    //Calculate the reflection vector R where n is the normal
  }

  void collide_box(Box b) {
    //Is the box "alive"?
    if (b.alive) {
      //Make a new position vector which is the position plus the velocity (using new PVector)
      //Why do we do this?
      //So that we don't update that way if we were going to collide.
      boolean collides;
      float DeltaX = pos.x - max(b.tl.x, min(pos.x, b.tl.x + b.wh.x));
      float DeltaY = pos.y - max(b.tl.y, min(pos.y, b.tl.y + b.wh.y));
      collides =  (DeltaX * DeltaX + DeltaY * DeltaY) < ((diameter/2) * (diameter/2));

      //Check if the circle and box are colliding
      if (collides) {
        //If they are
        if (b.wall) {
          if (pos.x <= 50 + (diameter / 2)) { // left wall
            velocity.x = velocity.x * -1;
          }
          if (pos.x >= 750 - (diameter / 2)) { // right wall
            velocity.x = velocity.x * -1;
          }
          if (pos.y <= 100 + (diameter / 2)) {
            velocity.y = velocity.y * -1;
          }
        } else { //increase score lol
          b.lives--;
          if(b.lives < 0){
            b.lives = 0;
          }
          if (b.lives == 0){
          b.alive = false;
          dead++;
          score++;
          }
          
          float dist;
          PVector corner;
          boolean cornerHit = false;
          //top left corner
          corner = new PVector(b.tl.x, b.tl.y);
          dist = PVector.dist(corner, pos);
          if (dist < 0) {
            dist *= -1;
          }
          if (dist <= (diameter / 2)) {
            velocity.x = velocity.x * -1;
            if(velocity.y > 0){
            velocity.y = velocity.y * -1;
            }
            cornerHit = true;
          }

          //top right corner
          corner = new PVector(b.tl.x + b.wh.x, b.tl.y);
          dist = PVector.dist(corner, pos);
          if (dist < 0) {
            dist *= -1;
          }
          if (dist <= (diameter / 2)) {
            velocity.x = velocity.x * -1;
            if(velocity.y > 0){
            velocity.y = velocity.y * -1;
            }
            cornerHit = true;
          }

          // bottom left
          corner = new PVector(b.tl.x, b.tl.y + b.wh.y);
          dist = PVector.dist(corner, pos);
          if (dist < 0) {
            dist *= -1;
          }
          if (dist <= (diameter / 2)) {
            velocity.x = velocity.x * -1;
            if(velocity.y < 0){
            velocity.y = velocity.y * -1;
            }
            cornerHit = true;
          }

          // bottom right
          corner = new PVector(b.tl.x + b.wh.x, b.tl.y + b. wh.y);
          dist = PVector.dist(corner, pos);
          if (dist < 0) {
            dist *= -1;
          }
          if (dist <= (diameter / 2)) {
            velocity.x = velocity.x * -1;
            if(velocity.y < 0){
            velocity.y = velocity.y * -1;
            }
            cornerHit = true;
          }
          if (!cornerHit) {

            //top
            dist = b.tl.y - pos.y;
            if (dist < 0) {
              dist *= -1;
            }
            if (dist <= (diameter / 2)) {
              if(velocity.y > 0){
                velocity.y = velocity.y * -1;
              }
            }

            //bottom
            dist = (b.tl.y + b.wh.y) - pos.y;
            if (dist < 0) {
              dist *= -1;
            }
            if (dist <= (diameter / 2)) {
              if(velocity.y < 0){
                velocity.y = velocity.y * -1;
              }
            }

            //left
            dist = b.tl.x - pos.x;
            if (dist < 0) {
              dist *= -1;
            }
            if (dist <= (diameter / 2)) {
              velocity.x = velocity.x * -1;
            }

            //right
            dist = (b.tl.x + b.wh.x) - pos.x;
            if (dist < 0) {
              dist *= -1;
            }
            if (dist <= (diameter / 2)) {
              velocity.x = velocity.x * -1;
            }
          }
        }
        //If it's not a wall, make it not alive, increase score
        //If it's on the left or right, flip the x velocity
        //If it's on the top or bottom, flip the y velocity
        //calculate bools
        //is the position between the y or x bounds of the box?
        //if so, flip the direction 
        //(ex, between x bounds means it's above or below)

        //otherwise
        //Use the same reflection, assume the box is a square
        //then treat the box as a circle
      }
    }
  }

  void draw () {
    //draw an ellipse, or draw with the shader via GameState
    ellipse(pos.x, pos.y, diameter, diameter);
  }
}
