export interface ColumnInfo{
  name: string  //原版名称
  type: ColumnType  //数据类型
}

export enum ColumnType{
  LONG,
  DOUBLE,
  STRING,
  BLOB
}