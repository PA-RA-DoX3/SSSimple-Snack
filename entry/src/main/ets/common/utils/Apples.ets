export class Apples{
  score:number=1
  destination:number=0
  //创建apple
  constructor(score:number,destination:number){
    this.score=score;
    this.destination=destination
  }

  get_destination():number{
    return this.destination
  }
}