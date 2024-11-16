export class Snack {
  body: number[] = []
  equipment : number[] = []
  facing: number = 0
  new_head :number = 0
  head: number = this.body[this.body.length-1]
  //设置蛇头位置
  upgrade_head(index:number){
    this.body[this.body.length+1] = index
  }
  //获取蛇头编号
  get_head(): number {
    return this.body[this.body.length-1]
  }

  //获取蛇尾编号
  get_tail(): number {
    return this.body[0]
  }

  //增加新的身体
  add_body(index: number) {
    this.body.push(index)
  }


  // //判断是否吃到apple
  // detect_eat_apple(apples_destination: number[]) {
  //   if (this.head == this.apple) {
  //
  //     return true
  //   }
  //   return false
  // }


  //蛇移动  返回是否移动成功
  move() :number{
    //首先将每个部分(除了蛇头)更新为下个部分的位置
    // for(let i = 0 ; i < this.body.length-1 ; i++){
    //   this.body[i]=this.body[i+1]
    // }
    //更新蛇头位置
    //右
    if (this.facing == 0) {
      this.new_head = this.get_head()+1
    }
    //上
    if (this.facing == 1) {
      this.new_head = this.get_head()-10
    }
    //左
    if (this.facing == 2) {
      this.new_head = this.get_head()-1
    }
    //下
    if (this.facing == 3) {
      this.new_head = this.get_head()+10
    }
    //错误
    return -1


    // //移动前
    // //判断是否撞墙
    // if (this.detect_hit_wall()) {
    //   // this.dead = 1
    //   // this.now_playing = false
    //   return false
    // }
    // //进行移动
    // //如果棋盘大小改变需要调整头位置
    //
    // //创建一个更新后的临时头
    // let temp_head = this.get_head()
    //
    // if (this.facing == 0) {
    //   temp_head += 1
    // }
    // if (this.facing == 1) {
    //   temp_head += -10
    // }
    // if (this.facing == 2) {
    //   temp_head += -1
    // }
    // if (this.facing == 3) {
    //   temp_head += 10
    // }
    // //移动后判断是否撞自己
    // if (this.detect_hit_self(temp_head)) {
    //   // this.dead = 2
    //   // this.now_playing = false
    //   return false
    // }
    // //再判断是否吃到积分
    //
    // if (this.detect_eat_apple()) {
    //   this.apple = Math.floor(Math.random() * 100)
    //   this.length_score += 1
    // } else {
    //   let tail = this.snake[0]
    //   this.game[tail] = false
    //   this.snake.shift()
    //
    //   //成功移动则把新蛇头加入身体
    //   this.body.push(temp_head)
    //   // this.game[this.head] = true
    //
    //   return true


  }
}