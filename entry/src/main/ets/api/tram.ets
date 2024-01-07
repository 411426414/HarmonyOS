import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'

/**
 * 我的关注
 * @param
* @returns
 */
export function subscribeList4(data) {
  return request("https://whyouguidianche.siisoo.com/realBus/subscribeList4?userId=1233666", http.RequestMethod.GET, data)
  // return request("api/whyg/subscribeList4?userId=1233666", http.RequestMethod.GET, data)
}

/**
 * 最近
 * @param
* @returns
 */
export function getLccStationList(data) {
  return request('api/whyg/getLccStationList', http.RequestMethod.GET, data)
}