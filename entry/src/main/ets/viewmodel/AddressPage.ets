class getAddressesFromLocationClass {
  latitude: number
  longitude: number
  locale: string
  placeName: string
  countryCode: string
  countryName: string
  administrativeArea: string
  subAdministrativeArea: string
  locality: string
  subLocality: string
  roadName: string
  subRoadName: string
  premises: string
  postalCode: string
  phoneNumber: string
  addressUrl: string
  descriptions: string[]
  descriptionsSize: number
  isFromMock: boolean
}

class getCountryCodeClass {
  country: string
  type: number
}

class reverseGeocodeReqClass {
  latitude: number
  longitude: number
  maxltems: number
}

class getCurrentLocationClass {
  latitude: number
  longitude: number
  altitude: number
  accuracy: number
  speed: number
  timeStamp: number
  direction: number
  timeSinceBoot: number
  additions: string
  additionSize: number
  isFromMock: boolean
}

@Component
export struct AddressPage {
  @State getCountryCode: getCountryCodeClass = { country: "CN", type: 4 }
  @State reverseGeocodeReq: reverseGeocodeReqClass = { "latitude": 30.457828, "longitude": 114.401695, "maxltems": 1 }
  @State getAddressesFromLocation: Array<getAddressesFromLocationClass> = [{
    "latitude": 30.457994,
    "longitude": 114.402469,
    "locale": "",
    "placeName": "Haomai Mansion ( Wudayuan 4th Road ) Haomai Mansion Block 1",
    "countryCode": "CN",
    "countryName": "China",
    "administrativeArea": "Hubei",
    "subAdministrativeArea": "",
    "locality": "Wuhan",
    "subLocality": "Jiang xia",
    "roadName": "Wudayuan 1stRoad",
    "subRoadName": "No .11",
    "premises": "",
    "postalCode": "",
    "phoneNumber": "",
    "addressUrl": "",
    "descriptions": ["Haomai Mansion ( Wudayuan 4th Road ) Haomai Mansion Block 1, Jiangxia , Wuhan ,Hubei"],
    "descriptionsSize": 1,
    "isFromMock": false
  }]
  @State getCurrentLocation: getCurrentLocationClass = {
    "latitude": 30.457828,
    "longitude": 114.401695,
    "altitude": 0,
    "accuracy": 30,
    "speed": 0,
    "timeStamp": 1705387502168,
    "direction": 0,
    "timeSinceBoot": 54311369828052,
    "additions": "",
    "additionSize": 0,
    "isFromMock": false
  }

  build() {

  }
}