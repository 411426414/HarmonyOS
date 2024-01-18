import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request'

// 会员登录
export function userLogin(data) {
  return request(`/api/user/login`, http.RequestMethod.POST, data)
}

// 会员中心
export function userIndex(data?) {
  return request(`/api/user/index`, http.RequestMethod.GET, data)
}
