export const getFirstWeekDay = (year, month) => { // 当月1号是周几    2
  const date = new Date(year, month - 1, 1)
  return date.getDay()
}

export const getMonthDayCount = (year, month) => { // 当月有多少天（最后一天的日期）
  const date = new Date(year, month, 0) // 下个月的第0天也就是当月最后一天
  return date.getDate()
}

export const getLastMonthRestDays = (year, month) => { // 当月1号前有几天（29，30，31，1，2，3，4）
  const days = getFirstWeekDay(year, month) // 当月1号周几
  let lastDate = getMonthDayCount(year, month - 1) // 上月最后一天
  const restDays = []

  while (restDays.length < days) {
    restDays.unshift(lastDate--)
  }
  return restDays
}

export const getNextMonthRestDays = (year, month) => { // 当月最后一天后下月的天数 （26，27，28，1，2，3，4）
  const lastMonthRestDayCount = getFirstWeekDay(year, month) // 1号前还有多少天
  const currentMonthDayCount = getMonthDayCount(year, month) // 当月最后一天
  const nextMonthRestDayCount = 42 - (lastMonthRestDayCount + currentMonthDayCount)
  let restDays = []

  for (let i = 1; i <= nextMonthRestDayCount; i++) {
    restDays.push(i)
  }
  return restDays
}

export const getFormatDate = (year, month, date) => { // 点击展示当前日期
  const dateArr = [year, month, date]

  for (let i = 1; i < dateArr.length; i++) {
    dateArr[i] < 10 && (dateArr[i] = '0' + dateArr[i])
  }
  return dateArr.join('-')
}