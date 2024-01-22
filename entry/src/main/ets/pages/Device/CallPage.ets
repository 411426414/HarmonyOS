import call from '@ohos.telephony.call';

@Entry
@Component
struct CallPage {
  @State message: string = '17683940985'

  build() {
    Row() {
      Column() {
        Button(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            call.makeCall(this.message, err => {
              console.log(`makeCall callback: err->${JSON.stringify(err)}`);
            });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}