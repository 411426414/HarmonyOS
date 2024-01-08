import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'


/**
 * 最近
 * @param
* @returns
 */
export function subscribeList4(userId) {
  return request(`/api/whyg/subscribeList4?userId=${userId}`, http.RequestMethod.GET)
}
/**
 * 我的关注
 * @param
* @returns
 */
export function getLccStationList(data) {
  return request(`/api/whyg/getLccStationList?longitude=${data.longitude}&latitude=${data.latitude}&status=${data.status}&userId=${data.userId}`, http.RequestMethod.GET, data)
}