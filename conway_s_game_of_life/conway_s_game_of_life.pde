// conways game of life. 

/*
  conway's game of life rules : 
  Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.

  Any live cell with two or three live neighbours lives on to the next generation.

  Any live cell with more than three live neighbours dies, as if by overpopulation.

  Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  
*/

int gridX = 100;
int gridY = 100;

boolean[][] grid; //<>//
boolean[][] grid_buffer;

boolean alive = true;
boolean dead = false;


int wx; //<>//
int wy; //<>//
int window_size; //<>//
int cell_size; //<>//


color green = color(0, 200, 0);
color black = color(0);


int interval = 100;
int lastRecordedTime = 0;

boolean pause;


void settings(){
  size(1000,1000);
}




void setup(){
  initialize_grid(); //<>//
  fill(255,255,255);
  
  wx =  0; //<>//
  wy =  0; //<>//
  window_size = 100; //<>//
  cell_size = height/window_size; //<>//
  pause = false;
  
  
  println(cell_size);
  
  background(0);
}
  

void initialize_grid(){

  grid = new boolean[gridY][gridX]; //<>//
  grid_buffer = new boolean[gridY][gridX];
  
  for(int i = 0; i < gridY; i++){ //<>//
    for(int o = 0; o < gridX; o++){ //<>//
      grid[i][o] = (random(0,1) > 0.5);   //<>//
      //print((grid[i][o])? '#':".");
    }
    //println();
  }
  
  //println("init");
}

boolean cell_at(int x, int y,boolean[][] g){
  if(x < 0 || x >= gridX || y < 0 || y >= gridY){return dead;}
  return g[y][x];
}



void copy_grid(){
  
   for(int i = 0; i < gridY; i++){
    for(int o = 0; o < gridX; o++){
      grid_buffer[i][o] = grid[i][o];
    }
  }
  
}



boolean update_cell(int x, int y){ //<>//
  
  int count = 0; //<>//
  
  for(int i = y - 1; i <= y + 1; i++){
    for(int o = x - 1; o <= x + 1; o++){ //<>//
      if(!(i == y && o == x)){count += (cell_at(o,i,grid_buffer))? 1 : 0;} //<>//
    }
  }
  

  if(grid[y][x]){
    
    if(count > 3){return dead;}
    if(count < 2){return dead;}
    return alive;
  }
  else{
    
    if(count == 3){return alive;}
    return dead;
  }
  
  }
  
   //<>//

void update_grid(){ //<>//
   
   copy_grid();
   
   for(int i = 0; i < gridY; i++){ //<>//
    for(int o = 0; o < gridX; o++){ //<>//
      grid[i][o] = update_cell(o,i);   //<>//
    }
  }
  

  
}




void draw_grid(){
 
  for(int i = wy; i < wy+window_size; i++){ //<>//
    for(int o = wx; o < wx+window_size; o++){ //<>//
      
      int sx = cell_size*(o-wx); //<>//
      int sy = cell_size*(i-wy); //<>//
     
      
      if(grid[i][o]){ fill(green);} //<>//
      else{fill(black);}
      
       square(sx,sy,cell_size);

      
    } //<>//
  } //<>//
}


  

 //<>//

void keyPressed(){
  if(key == 'r'){
    initialize_grid();
  }
  
  else if(key == ' '){pause = !pause;}
  
  else if(pause && key == 's'){update_grid();}
  
  else if(key == 'c'){
    for(int y = 0; y < gridY; y++){
      for(int x = 0; x < gridX; x++){grid[y][x] = dead;}
    }
  }
  
  
}


void draw(){
  draw_grid();
  
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      update_grid();
      lastRecordedTime = millis();
    }
  }
  
  
  if(pause && mousePressed){
    
    int gx = wx + (mouseX/cell_size);
    int gy = wy + (mouseY/cell_size);
    
    constrain(gx, 0,gridX);
    constrain(gy, 0,gridY);
    
    grid[gy][gx] = alive;
  }
  
  
  else if(pause && !mousePressed){copy_grid();}

  
   //<>//
}
