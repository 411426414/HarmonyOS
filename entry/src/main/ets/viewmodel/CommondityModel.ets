export class Commodity {
  id: number;
  type: string;
  title: string
  subtitle: string
  category_ids: string
  image: string
  image_wh: {
    w: string,
    h: string
  }
  images: string[]
  params: {
    title: string
    content: string
  }[]
  original_price: string
  price: string[] | number[]
  is_sku: number
  limit_type: string
  limit_num: number;
  likes: number;
  views: number;
  sales: number;
  sales_show_type: string
  stock_show_type: string
  show_sales: number;
  service_ids: number[]
  dispatch_type: string
  dispatch_id: number;
  is_offline: number;
  status: string
  weigh: number;
  createtime: string
  updatetime: string
  deletetime: string
  stock: string
  activities: {
    goods_ids: string
    end_time: string
    id: string
    type: string
    richtext_id: string
    rules: {
      is_commission?: string
      is_free_shipping?: string
      sales_show_type?: string
      ladders?: {
        ladder_one?: string
        ladder_two?: string
        ladder_three?: string
      }
      team_num?: string
      is_alone?: string
      is_fictitious?: string
      fictitious_num?: string
      fictitious_time?: string
      is_team_card?: string
      is_leader_discount?: string
      valid_time?: string
      limit_num?: string
      refund_type?: string
      order_auto_close?: string
    }
    richtext_title: string
    type_text: string
    start_time: string
    activity_sku_prices: {
      id: number
      activity_id: number
      goods_sku_price_id: number
      goods_id: number
      stock: number
      price: string
      ext: {
        is_leader_discount: string
        ladders: {
          ladder_level: string
          ladder: string
          ladder_price?: string
          leader_ladder_price: string
        }[]
      } | {
        is_leader_discount: string
        leader_price: string
      }
      status: string
      createtime: string
      updatetime: string
      status_text: string
      sales: boolean | string
    }[]
    classify: string
    prehead_time: string
    title: string
    status: string
    status_text: string
  }[]
  promos: {
    id: string
    title: string
    type: string
    type_text: string
    classify: string
    goods_ids: string
    richtext_id: string
    richtext_title: string
    prehead_time: string
    start_time: string
    end_time: string
    rules: {
      type: string
      discounts: {
        full: string
        discount: string
      }[]
    }
    status: string
    status_text: string
    tag: string
    tags: string[]
    texts: string[]
  }[]
  status_text: string
  type_text: string
  dispatch_type_text: string
}
