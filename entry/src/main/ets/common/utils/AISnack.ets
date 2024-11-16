import { Snack } from "./Snack";

export class AISnack extends Snack{
  type :number = 2


  get_facing(type : number){
    switch (type){
      case 0:{
        let is_legal =false
        let temp_facing = 0
        do{
          temp_facing = Math.floor(Math.random()*3)
          if(Math.abs(temp_facing - this.facing) != 2){
            is_legal = true
          }
        }while(!is_legal)
        this.facing = temp_facing
        break;
      }

      default :{this.facing = 1}
    }
  }
  // ai_constructor(type :number) :number[]{
  //   switch (type){
  //     case 0 :{
  //       let facing =Math.floor(Math.random()*4)
  //
  //     }
  //   }
  // }
}