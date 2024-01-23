@Component
export default struct Input {
  title: string
  placeholder: string
  inputType: InputType = InputType.Normal
  icon: Resource
  @State isFocus: boolean = false

  build() {
    Column() {
      Text(this.title)
        .width('100%')
        .textAlign(TextAlign.Start)
        .fontSize(16)
        .fontWeight(500)
        .fontColor('#001648')
        .margin({ bottom: 14 })
      Flex({ alignItems: ItemAlign.Center }) {
        Image(this.icon).width(30).height(30)
        TextInput({ placeholder: this.placeholder })
          .placeholderColor('rgba(0,40,132,0,6')
          .backgroundColor(Color.White)
          .style(TextInputStyle.Inline)
          .width('100%')
          .type(this.inputType)
          .onFocus(() => {
            this.isFocus = true
          })
          .onBlur(() => {
            this.isFocus = false
          })
      }
      .height(50)
      .width('100%')
      .padding({ left: 10, right: 10 })
      .borderRadius(10)
      .border({
        width: this.isFocus ? 2 : 0,
        color: '#002884'
      })
    }

  }
}