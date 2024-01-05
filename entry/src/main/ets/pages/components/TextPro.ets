import Constant from '../../common/constants/Constant'

@Component
export default struct TextPro {
  private inputImage?: Resource;
  private hintText?: string;

  build() {
    Row() {
      Image(this.inputImage !== undefined ? this.inputImage : '')
        .width(Constant.INPUT_IMAGE_SIZE)
        .height(Constant.INPUT_IMAGE_SIZE)
        .margin({ left: 12 })
      TextInput({ placeholder: this.hintText })
        .fontSize(16)
        .padding({ left: 16 })
        .placeholderColor('#99000000')
        .backgroundColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .fontStyle(FontStyle.Normal)
        .fontColor(Color.Black)
        .margin({ right: 32 })
        .layoutWeight(1)
        .height(48)
    }
    .margin({ top: 24 })
    .borderRadius(24)
    .backgroundColor(Color.White)
    .width('93.3%')
    .height(64)
  }
}