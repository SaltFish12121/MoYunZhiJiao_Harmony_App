import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common'
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo';
import Logger from './Logger'

const DB_FILENAME: string = 'ShuFaPingJia.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore

  //数据库初始化，项目启动时调用
  initDB(context: common.UIAbilityContext): Promise<void> {
    let config: relationalStore.StoreConfig = {
      name: DB_FILENAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise<void>((resolve, reject) => {
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => {
          this.rdbStore = rdbStore
          Logger.debug('DB', 'rdbStore 初始化完成！')
          console.log('DB', 'rdbStore 初始化完成')
          resolve()
        })
        .catch(reason => {
          Logger.debug('DB', 'rdbStore 初始化异常', JSON.stringify(reason))
          console.log('DB', 'rdbStore 初始化异常')
          reject(reason)
        })
    })
  }

  createTable(createSQL: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.rdbStore.executeSql(createSQL)
        .then(() => {
          Logger.debug('DB', '创建表成功', createSQL)
          console.log('DB', '创建表成功')
          resolve()
        })
        .catch(err => {
          Logger.error('DB', '创建表失败,' + err.message, JSON.stringify(err))
          console.log('DB', '创建表失败')
          reject(err)
        })
    })
  }

  //增
  insert(tableName: string, obj: any, columns: ColumnInfo[]): Promise<number> {
    return new Promise((resolve, reject) => {
      // 1.构建新增数据
      let value = this.buildValueBucket(obj, columns)
      // 2.新增
      this.rdbStore.insert(tableName, value, (err, id) => {
        if (err) {
          Logger.error('DB', '新增失败！', JSON.stringify(err))
          console.log('DB', '新增失败')
          reject(err)
        } else {
          Logger.debug('DB', '新增成功！新增id：', id.toString())
          console.log('DB', '新增成功')
          resolve(id)
        }
      })
    })
  }

  //删
  delete(predicates: relationalStore.RdbPredicates): Promise<number> {
    return new Promise((resolve, reject) => {
      this.rdbStore.delete(predicates, (err, rows) => {
        if (err) {
          Logger.error('删除失败！', JSON.stringify(err))
          console.log('DB', '删除失败')
          reject(err)
        } else {
          Logger.debug('删除成功！删除行数：', rows.toString())
          console.log('DB', '删除成功')
          resolve(rows)
        }
      })
    })
  }

  //改 全
  updateAll(obj: any, predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<number> {
    return new Promise((resolve, reject) => {
      // 1.构建更新数据
      let value = this.buildValueBucket(obj, columns);

      // 2.更新
      this.rdbStore.update(value, predicates, (err, rows) => {
        if (err) {
          Logger.error(`更新失败！`, JSON.stringify(err));
          console.log('DB', '更新失败')
          reject(err);
        } else {
          Logger.debug(`更新成功！，更新行数：`, rows.toString());
          console.log('DB', '更新成功')
          resolve(rows);
        }
      });
    });
  }


  //改 单
  updateById(id: number, column: string, newValue: any, predicates: relationalStore.RdbPredicates): Promise<number> {
    return new Promise((resolve, reject) => {
      // 1.构建更新数据
      let value = {};
      value[column] = newValue;

      // 2.构建条件
      predicates.equalTo('id', id);

      // 3.更新
      this.rdbStore.update(value, predicates, (err, rows) => {
        if (err) {
          Logger.error('DB', `更新失败！`, JSON.stringify(err));
          console.log('DB', '更新失败')
          reject(err);
        } else {
          Logger.debug('DB', `更新成功！，更新行数：`, rows.toString());
          console.log('DB', '更新成功')
          resolve(rows);
        }
      });
    });
  }



  //查
  queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]> {
    return new Promise((resolve, reject) => {
      this.rdbStore.query(predicates, columns.map(info => info.name), (err, result) => {
        if (err) {
          Logger.error('DB', '查询失败！', JSON.stringify(err))
          console.log('DB', '查询失败')
          reject(err)
        } else {
          Logger.debug('DB', '查询成功！查询行数：', result.rowCount.toString())
          console.log('DB', '查询成功')
          resolve(this.parseResultSet(result, columns))
        }
      })
    })
  }

  parseResultSet<T> (result: relationalStore.ResultSet, columns: ColumnInfo[]): T[] {
    // 1.声明最终返回的结果
    let arr = []
    // 2.判断是否有结果
    if (result.rowCount <= 0) {
      return arr
    }
    // 3.处理结果
    while (!result.isAtLastRow) {
      // 3.1.去下一行
      result.goToNextRow()
      // 3.2.解析这行数据，转为对象
      let obj = {}
      columns.forEach(info => {
        let val = null
        switch (info.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.name))
            break
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.name))
            break
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.name))
            break
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.name))
            break
        }
        obj[info.name] = val
      })
      // 3.3.将对象填入结果数组
      arr.push(obj)
      Logger.debug('DB', '查询到数据：', JSON.stringify(obj))
      console.log('DB', '查询到数据')
    }
    return arr
  }

  buildValueBucket(obj: any, columns: ColumnInfo[]): relationalStore.ValuesBucket {
    let value = {}
    columns.forEach(info => {
      let val = obj[info.name]
      if (typeof val !== 'undefined') {
        value[info.name] = val
      }
    })
    return value
  }
}


let dbUtil: DbUtil = new DbUtil();

export default dbUtil as DbUtil