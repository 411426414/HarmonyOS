// 公用的数据源对象，以后子要涉及LazyForeach都可以使用该工具
export class CommonDataSource<T> implements IDataSource {
  // 要加载的数据
  private dataArray: T[] = [];
  // 数据更新的监听器对象
  private listeners: DataChangeListener[] = [];

  constructor(element: T[]) {
    this.dataArray = element;
  }

  // 根据索引获取数组中的数据
  getData(index: number) {
    return this.dataArray[index]
  }

  // 获取数据源中的数据长度
  totalCount(): number {
    return this.dataArray.length;
  }

  // 给数据源中新增一个数组数据,并触发页面更新
  addData(index: number, data: T) {
    this.dataArray = this.dataArray.concat(data);
    this.notifyDataAdd(index)
  }

  // 更新数据源中的一个数组数据,并触发页面更新
  pushData(index: number, data: T) {
    this.dataArray.push(data)
    this.notifyDataAdd(this.dataArray.length - 1)
  }

  // 删除数据源中的一个数组数据,并触发页面更新
  deleteData(index: number) {
    this.dataArray.splice(index, 1);
    this.notifyDataDelete(index);
  }

  // 新的数据注册到数据源的时候，触发监听器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 数据从数据源中移除的时候， 触发监听器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有组件
  notifyDataReload(): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要将指定index对应索引的数据插入，需要重建该组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处数据有变化，需要重建该组件
  notifyDataChange(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要将指定index对应索引的数据删除，需要重建该组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    })
  }
}