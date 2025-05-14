

class Particle {
  
  int id;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  color charge;
  
  Particle(PVector p, PVector v,int m, color c){
    this.id = (int) random(0,100);
    this.position = p;
    this.velocity = v;
    this.mass = m;
    this.charge = c;
    this.acceleration = new  PVector(0,0);
  }
  
  Particle(float x,float y,float vx, float vy){
    this.id = (int) random(0,100);
    this.position = new PVector(x,y);
    this.velocity = new PVector(vx,vy);
    this.acceleration = new PVector(0,0);
    this.mass = random(1,100);
    this.charge = color(random(0,255),random(0,255),random(0,255));
  }
  
  
  void update(ArrayList<Particle>particles){
    
    this.acceleration.add(gravity(particles));
    this.velocity.add(acceleration);
    this.position.add(velocity);
    this.wall_collision();
    this.particle_collision(particles);
    
    this.acceleration.mult(0);
    
  }
  
  
  PVector gravity(ArrayList<Particle>particles){
    PVector g = new PVector(0,0);
    
    for(Particle other : particles){
       
       if(this != other){
      
         float dist = this.position.dist(other.position);
         PVector direction = PVector.sub(other.position,this.position).div(dist);   
         float magnitude = (this.mass*other.mass)/sq(dist);
         
         g.add(direction.mult(magnitude));
      }
    }
    
    return g.div(this.mass);
  
  }
  
  
  
  void wall_collision(){
    float curr_x = this.position.x;
    float curr_y = this.position.y;
    
    if(curr_x - mass <= 0 || curr_x + mass >= width)  {this.velocity.x *= -1; this.position.x = curr_x%width;}
    if(curr_y - mass <= 0 || curr_y + mass >= height) {this.velocity.y *= -1; this.position.y = curr_y%height;}    
    
  }
  
  
  void particle_collision(ArrayList<Particle> particles){
    
    ArrayList<Particle[]> collided_particles = new  ArrayList<Particle[]>(); 

    
    for(Particle other : particles){
      
      if(this.collision(other) && this != other){
        
        PVector direction = PVector.sub(this.position,other.position).normalize();   
        float delta =  0.5 * (this.position.dist(other.position) - (this.mass + other.mass));
        
        this.position.sub(PVector.mult(direction,delta));
        
        other.position.add(PVector.mult(direction,delta));
        
        Particle[] t = {this,other};
        collided_particles.add(t);
            
        
      }
    
    }
    
    
    for(Particle[] c : collided_particles ){
      break;
    }
    
    
  }
  
  
  boolean collision(Particle other){
    //PVector dist = PVector.sub(other.position,this.position);
    //return (dist.mag() <= (this.mass+other.mass));
    PVector dist = PVector.sub(other.position,this.position);
    return (dist.mag() <= (this.mass+other.mass));
  }
    

  
  
  
  
  
  void display(){
    ellipseMode(RADIUS);
    fill(this.charge);
    circle(this.position.x,this.position.y,this.mass);
    fill(255);
    text(""+id,this.position.x,this.position.y);
  }
  
  
  
  void info(){
    println("id:"+this.id+" position: ("+this.position.x+","+this.position.y+") velocity : ("+this.velocity.x+","+this.velocity.y+")");
  
  }
  
  
  
  
}
