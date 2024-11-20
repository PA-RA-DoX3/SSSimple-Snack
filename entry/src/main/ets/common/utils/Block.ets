import { EditableLeftIconType } from "@kit.ArkUI";

@Component
export struct  Block {
  @Prop board_size: number = 0;
  @Prop status: number = 0;
  @Prop index: number = 0;
  @State zoom: string = this.get_init_zoom();
  //颜色
  @State b_color:Resource =$r("app.color.deep_background");

  //显示之前确定颜色，之后改为图片
  image(): Resource{
    let type :number
    if(this.status<10){
      type = this.status
    }else {
      type = Math.floor(this.status / 10) *10
    }
    switch (type){
      case 0 :{
        return $r("app.color.deep_background")
      }
      case 1 :{
        return $r("app.color.apple_normal")
      }
      case 3 :{
        return $r("app.color.apple_normal")
      }
      case 5 :{
        return $r("app.color.apple_normal")
      }
      case 10 :{
        return $r("app.color.player")
      }
      case 20:{
        return $r("app.color.AI_color0")
      }
      case 30:{
        return $r("app.color.AI_color1")
      }
      case 40:{
        return $r("app.color.AI_color2")
      }
      case 50:{
        return $r("app.color.AI_color3")
      }
      case 60:{
        return $r("app.color.AI_color4")
      }
      case 70:{
        return $r("app.color.AI_color5")
      }
      case 80:{
        return $r("app.color.AI_color6")
      }
      default :{
        return $r("app.color.AI_color0")
      }
    }
  }

  pic() {
    if (this.status == 1) {
      return $rawfile('small_apple.png')
    } else if (this.status == 3) {
      return $rawfile('middle_apple.png')
    } else if (this.status > 9) {
      if (this.status < 20) {
        switch (this.status % 10) {
          case 0: {
            return $rawfile('right.png')
          }
          case 1: {
            return $rawfile('up.png')
          }
          case 2: {
            return $rawfile('left.png')
          }
          case 3: {
            return $rawfile('down.png')
          }
          default: {
            return null
          }
        }
      } else {
        switch (this.status % 10) {
          case 0: {
            return $rawfile('ai_rightandleft.png')
          }
          case 1: {
            return $rawfile('ai_upanddown.png')
          }
          case 2: {
            return $rawfile('ai_rightandleft.png')
          }
          case 3: {
            return $rawfile('ai_upanddown.png')
          }
          default: {
            return null
          }
        }
      }

    } else {
      return null
    }

  }

  build() {
    Row() {
      Image(this.pic())
        .borderRadius(this.board_size * 4)
    }
    .width(this.zoom)
    .height(this.zoom)
    .animation({ duration: 200, delay: this.index * 3, curve: Curve.ExtremeDeceleration })
    .backgroundColor(this.image())
    .borderRadius(this.board_size * 4)
    .onAreaChange(()=>{
      this.zoom = "100%"
    })
  }

  get_init_zoom() {
    if (this.board_size == 0) {
      return "1%"
    }
    return "100%"
  }

}