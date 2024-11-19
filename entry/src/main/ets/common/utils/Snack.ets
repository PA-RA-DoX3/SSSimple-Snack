export class Snack {
  body: number[] = []
  facing: number = 0
  new_head :number = 0
  //编号，默认为10，指定为玩家 ，后续编号由主游戏确定
  index : number = 1
  //刷新时间
  refresh_time :number = 400
  //长度，朝向 ，所属蛇的标签，尾巴的位置
  constructor(length:number , facing? :number ,index = 10,tail = 0) {
    for(let i = 0 ;i <length ; i++){
      this.body.push(tail)
      tail++
    }
    if(facing == undefined) {
      facing = Math.floor(Math.random()*4)
    }
    this.index = index
  }

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

  //蛇移动  返回是否移动成功
  //只更新蛇头
  move(size = 10 , facing?:number) {
    let f :number
    if(facing == undefined){
      f = this.facing
    }else {
      f = facing
    }
    if(f == 0){
      this.new_head = this.get_head() + 1
    }
    if(f == 1){
      this.new_head = this.get_head() - size
    }
    if(f == 2){
      this.new_head = this.get_head() - 1
    }
    if(f == 3){
      this.new_head = this.get_head() + size
    }
  }


   detect_hit_self() {
    if (this.body.includes(this.new_head)) {
      return true
    }
    return false
  }

}