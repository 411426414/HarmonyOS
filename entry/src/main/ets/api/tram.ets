import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'


/**
 * 最近
 * @param
* @returns
 */
export function subscribeList4(data) {
  return request(`/api/whyg/subscribeList4`, http.RequestMethod.GET, data)
}
/**
 * 我的关注
 * @param
* @returns
 */
export function getLccStationList(data?) {
  return request(`/api/whyg/getLccStationList`, http.RequestMethod.GET, data)
}
/**
 * 查看站点信息：大吕路，城铁汤逊湖-》光谷植物园
 * @param
* @returns
 */
export function getLccInfoByStationId(data?) {
  return request(`/api/whyg/getLccInfoByStationId`, http.RequestMethod.GET, data)
}