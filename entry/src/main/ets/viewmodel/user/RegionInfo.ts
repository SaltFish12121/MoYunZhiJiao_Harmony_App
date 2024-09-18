export default class RegionInfo{
  id: number  //地区id
  name: string  //地区名
  parentId: number  //父地区id

  constructor(id: number = 0, name: string = '', parentId: number = 0) {
    this.id = id
    this.name = name
    this.parentId = parentId
  }
}