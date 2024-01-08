import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'


/**
 *  获取轮播图列表
 */
export function BannerList(id?) {
  return request(`https://gzh.411426414.top/api/graduation/banner/list?id=${id}`, http.RequestMethod.GET)
}