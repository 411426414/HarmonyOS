export function convertToGetParams(obj) {
  let getParams = '';
  for (let key in obj) {
    if (Object.prototype.hasOwnProperty.call(obj, key)) {
      const value = encodeURIComponent(obj[key]); // 编码特殊字符
      getParams += `${encodeURIComponent(key)}=${value}&`;
    }
  }
  let params = getParams ? getParams.slice(0, -1) : ''; // 去除最后多余的 "&" 符号
  console.log('33333333333', params.toString())
  return params
}