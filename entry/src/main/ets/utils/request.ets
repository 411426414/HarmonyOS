import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
// 导入预定好的数据响应格式
import Response from '../utils/Response'

// 导出去一个请求函数，这样开发者就可以像axios一样的风格请求数据
export function request(url: string, method: http.RequestMethod, data?: any) {

  // 定义一个后台请求的基地址
  const BASE_URL = "https://shopro.411426414.top"
  if (url.indexOf('https://') == -1) {
    url = BASE_URL + url
  }
  if (method == http.RequestMethod.GET) {
    console.log('data', JSON.stringify(data))
    let getParams = '?';
    for (let key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        const value = encodeURIComponent(data[key]); // 编码特殊字符
        getParams += `${encodeURIComponent(key)}=${value}&`;
      }
    }
    let params = getParams ? getParams.slice(0, -1) : ''; // 去除最后多余的 "&" 符号

    url = url + params
  }

  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: method,
    header: {
      'Content-Type': 'application/json'
    },
    // 携带额外参数：当使用POST请求时此字段用于传递内容
    extraData: JSON.stringify(data),
    // 可选，指定返回数据的类型
    // expectDataType: http.HttpDataType.STRING,
    // 可选，默认为true
    // usingCache: true,
    // 可选，默认为1
    // priority: 1,
    // 可选，默认为60000ms
    // connectTimeout: 60000,
    // readTimeout: 60000,
    // 可选，协议类型默认值由系统自动指定
    // usingProtocol: http.HttpProtocol.HTTP1_1,
  });

  let response = new Response();

  // 处理数据，并返回
  return responseResult
    .then((value: http.HttpResponse) => {
      if (value.responseCode === 200) {
        // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
        let res: Response = JSON.parse(`${value.result}`);
        response.code = res.code;
        response.msg = res.msg;
        response.time = res.time;
        response.data = res.data;
        response.total = res.total;
      } else {
        response.msg = '请求错误';
        response.code = 400;
      }
      return response;
    })
    .catch(() => {
      response.msg = '请求错误';
      response.code = 400;
      return response;
    });
}