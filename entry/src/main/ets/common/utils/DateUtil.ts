class DateUtil{

  formatDate(num: number): string{
    let date = new Date(num)
    let year = date.getFullYear()
    let month = date.getMonth()+1
    let day = date.getDate()
    let m = month < 10 ? '0' + month : month
    let d = day < 10 ? '0' + day : day
    return `${year}/${m}/${d}`
  }

  beginTimeOfDay(date: Date){
    let d = new Date(date.getFullYear(), date.getMonth(), date.getDate())
    return d.getTime()
  }

  splitDate(num: number): { year: string, month: string, day: string } {
    let date = new Date(num)
    let year = date.getFullYear().toString()
    let month = (date.getMonth() + 1).toString().padStart(2, '0')
    let day = date.getDate().toString().padStart(2, '0')
    return { year, month, day }
  }
}

let dateUtil = new DateUtil()

export default dateUtil as DateUtil