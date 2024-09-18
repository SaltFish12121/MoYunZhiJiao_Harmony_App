/**
 * 数据库建表语句
 */
import relationalStore from '@ohos.data.relationalStore'
import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import DbUtil from '../common/utils/DbUtil'
import { UserPO } from '../common/bean/UserPO'

const CREATE_TABLE_SQL: string = `
  CREATE TABLE IF NOT EXISTS user (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT NOT NULL,
     studentNumber TEXT NOT NULL,
     userPassword TEXT NOT NULL,
     regionId INTEGER NOT NULL,
     regionName TEXT NOT NULL,
     regionParentId INTEGER NOT NULL,
     gender TEXT NOT NULL,
     otherName TEXT NOT NULL,
     klassId INTEGER NOT NULL,
     klassName TEXT NOT NULL,
     klassSchool TEXT NOT NULL,
     klassGrade TEXT NOT NULL,
     klassTeacher TEXT NOT NULL,
     phoneNumber TEXT NOT NULL,
     email TEXT NOT NULL,
     idNumber TEXT NOT NULL,
     ifBinding BOOLEAN
  )
 `

//数据库列
const COLUMNS: ColumnInfo[] = [
  {name: 'id', type: ColumnType.LONG},
  {name: 'name', type: ColumnType.STRING},
  {name: 'studentNumber', type: ColumnType.STRING},
  {name: 'userPassword', type: ColumnType.STRING},
  {name: 'regionId', type: ColumnType.LONG},
  {name: 'regionName', type: ColumnType.STRING},
  {name: 'regionParentId', type: ColumnType.LONG},
  {name: 'gender', type: ColumnType.STRING},
  {name: 'otherName', type: ColumnType.STRING},
  {name: 'klassId', type: ColumnType.LONG},
  {name: 'klassName', type: ColumnType.STRING},
  {name: 'klassSchool', type: ColumnType.STRING},
  {name: 'klassGrade', type: ColumnType.STRING},
  {name: 'klassTeacher', type: ColumnType.STRING},
  {name: 'phoneNumber', type: ColumnType.STRING},
  {name: 'email', type: ColumnType.STRING},
  {name: 'idNumber', type: ColumnType.STRING},
  {name: 'ifBinding', type: ColumnType.BLOB}
]

const TABLE_NAME = 'user'
const ID_COLUMN = 'id'


class UserModel {
  getCreateTableSql(): string {
    return CREATE_TABLE_SQL
  }

  insert(record: UserPO): Promise<number>{
    return DbUtil.insert(TABLE_NAME, record, COLUMNS)
  }

  deleteById(id: number): Promise<number>{
    // 1.删除条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(ID_COLUMN, id)
    // 2.删除
    return DbUtil.delete(predicates)
  }

  listByDate(date: number): Promise<UserPO[]>{
    // 1.查询条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME)
    predicates.equalTo(ID_COLUMN, date)//?
    // 2.查询
    return DbUtil.queryForList(predicates, COLUMNS)
  }

  updateUserColumnById(id: number, column: keyof UserPO, newValue: string | number | boolean): Promise<number> {
    // 1.更新条件
    let predicates = new relationalStore.RdbPredicates(TABLE_NAME);
    predicates.equalTo(ID_COLUMN, id);

    // 2.更新
    return DbUtil.updateById(id, column, newValue, predicates);
  }


}


let userModel = new UserModel()

export default userModel as UserModel