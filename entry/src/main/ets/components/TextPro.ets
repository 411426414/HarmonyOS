import Constant from '../constants/Constant'

@Component
export default struct TextPro {
  @Link textContent: string;
  private inputImage?: Resource;
  private hintText?: string;
  private isPass?: boolean = false;

  build() {
    Row() {
      Image(this.inputImage !== undefined ? this.inputImage : '')
        .width(Constant.INPUT_IMAGE_SIZE)
        .height(Constant.INPUT_IMAGE_SIZE)
        .margin({ left: 12 })
      TextInput({ text: this.textContent, placeholder: this.hintText })
        .type(this.isPass ? InputType.Password : InputType.Normal)
        .fontSize(16)
        .padding({ left: 16 })
        .placeholderColor('#99000000')
        .backgroundColor(Color.White)
          // .fontWeight(FontWeight.Normal)
          // .fontStyle(FontStyle.Normal)
        .fontColor(Color.Black)
        .margin({ right: 32 })
        .layoutWeight(1)
        .height(36)
        .onChange((value: string) => {
          if (this.onItemChange !== undefined) {
            this.onItemChange(value)
          }
        })
    }
    .margin({ top: 24 })
    .borderRadius(24)
    .backgroundColor(Color.White)
    .width('93.3%')
    .height(48)
  }

  // 父组件传递一个事件函数,当子组件的商品被点击时,调用该事件函数,并把被点击的商品传递给它
  private onItemChange? = (data) => {
  }
}