class Ball {
  PVector location;
  PVector velocity;
  PVector gravity;
  PVector wind;
  float d = 25;





  Ball() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1, 1), 0);
    gravity = new PVector(0, .05); //remember positive y is going down
  }


  void run() {
    wind = new PVector(random(-.002, .002), 0);
    gravity.add(wind);
    //    background(230);
    //    fill(#001BFF);
    location.add(velocity);
    //velocity.add(gravity);

    if ( location.x < 0|| location.x > width) {
      velocity.x = -velocity.x;
    }
    if ( location.y < 0 || location.y > height) {
      velocity.y = -velocity.y;
    }
    if (location.x < -10 || location.x > width+10) {
      location.x = width/2;
    }
    if (location.y < -10 || location.y > height+10) {
      location.y = height/2;
    }
    fill (255);
    ellipse(location.x, location.y, d, d);
  }
  PVector location() {
    return location;
  }
}

