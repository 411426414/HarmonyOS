import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/request';
/**
 * 最近
 * @param
* @returns
 */
export function subscribeList4(data) {
    return request("/api/whyg/getLccStationList", http.RequestMethod.GET, data);
}
/**
 * 我的关注
 * @param
* @returns
 */
export function getLccStationList(data) {
    data['url'] = encodeURIComponent('https://shopro.411426414.top/api/whyg/getLccStationList');
    return request(`/api/whyg/getLccStationList`, http.RequestMethod.GET, data);
}
//# sourceMappingURL=tram.js.map