import http from '@ohos.net.http';
import Logger from '../common/utils/Logger';
//导入封装好的请求
import { request } from '../utils/request'

// 会员登录
export function userLogin(data) {
  return request(`/api/user/login`, http.RequestMethod.POST, data)
}
