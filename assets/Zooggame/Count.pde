class Count {
  int count_all;
  int count_dead;
  int count_hit;
  int count_remain;

  Count(int count_all) {
    this.count_all = count_all;
  }

  void display() {
    count_remain = count_all - count_dead;
    
    textAlign(LEFT, BOTTOM);
    fill(200);
    
    textSize(22);
    text("hitcount: "+count_hit, 0, height);
    
    textAlign(RIGHT, BOTTOM);
    text("dead zoog: "+count_remain+"/"+count_all, width, height);
  }
}