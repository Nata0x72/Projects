

int number_particles = 2;
ArrayList<Particle> particles;

boolean paused;

void setup(){
  
  size(750,500);
  background(0);
  fill(255);
  
  particles = new ArrayList<Particle>();
  paused = false;
}




void mouseClicked(){
  
  Particle p = new Particle(mouseX,mouseY,0,0);
  particles.add(p);
  
  
}



void mouseDragged(){
  
  for(Particle p : particles){
     if(dist(p.position.x,p.position.y,mouseX,mouseY)  < p.mass){
        p.position.x = mouseX;
        p.position.y = mouseY;
     }
  }

}




void keyPressed(){
  
  if(key == 'c'){particles = new ArrayList<Particle>();}
  
  else if(key == ' '){paused = !paused;}
  
  else if(key == 'r'){particles.remove(particles.size()-1);}
  

}



void draw(){
  background(0);
  
 
    for(Particle p : particles){
      
      if(!paused){p.update(particles);}
      p.display();
      p.info();
      
      
   }  
}
