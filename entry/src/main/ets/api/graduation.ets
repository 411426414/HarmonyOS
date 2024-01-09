import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'


/**
 *  获取轮播图列表
 */
export function BannerList() {
  return request(`https://gzh.411426414.top/api/graduation/banner/list`, http.RequestMethod.GET)
}
/**
 *  获取信息分类列表
 */
export function ClassInfoList() {
  return request(`/api/zixun/classification`, http.RequestMethod.GET)
}
/**
 *  获取信息列表
 */
export function ZixunInfoList(data: {
  search:string
  type:number
  page:number
  pagesize:number
}) {
  return request(`/api/zixun/infolist`, http.RequestMethod.GET, data)
}