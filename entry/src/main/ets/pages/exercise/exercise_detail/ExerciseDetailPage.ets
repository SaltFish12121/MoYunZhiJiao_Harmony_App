import router from '@ohos.router'
import { Header, HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Entry
@Component
struct ExerciseDetialPage {
  @State Number: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
  private  Number2: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  @State submit: SubmitWritingInfo = new SubmitWritingInfo(0, $r('app.media.exercise_test1'))

  @State word: WordInfo[][] = [
    [
      new WordInfo($r('app.media.word1'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6'), $r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000088')),
      new WordInfo($r('app.media.word2'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000069')),
      new WordInfo($r('app.media.word3'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000071')),
      new WordInfo($r('app.media.word4') , [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000047')),
      new WordInfo($r('app.media.word5') , [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000033')),
      new WordInfo($r('app.media.word6') , [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000088')),
      new WordInfo($r('app.media.word7') , [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000022')),
      new WordInfo($r('app.media.word8') , [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')], 81, $r('app.media.KaitiChineseStroke_val_000000000033'))
    ],
    [
      new WordInfo($r('app.media.word9'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word10'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word11'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word12'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word13'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word14'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word15'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word16'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word17'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word18'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word19'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word20'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word21'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word22'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word23'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word24'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word25'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word26'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word27'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word28'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word29'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word30'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word31'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word32'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word33'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word34'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word35'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word36'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word37'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word38'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word39'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word40'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word41'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word42'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word43'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word44'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word45'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word46'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word47'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word48'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word49'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word50'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word51'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word52'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word53'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word54'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word55'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word56'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word57'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word58'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word59'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word60'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word61'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word62'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word63'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word64'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word65'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word66'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word67'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word68'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word69'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word70'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word71'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word72'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word73'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word74'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word75'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word76'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word77'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word78'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word79'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word80'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word81'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word82'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word83'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word84'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word85'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word86'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word87'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word88'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ],
    [
      new WordInfo($r('app.media.word89'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word90'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word91'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word92'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word93'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word94'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word95'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')]),
      new WordInfo($r('app.media.word96'), [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3'), $r('app.media.0009_4'), $r('app.media.0009_5'), $r('app.media.0009_6')])
    ]
  ]

  @State title: string = '详情'

  build() {
    Scroll(){
      Column(){
        //1头部
        HeaderTitle({ title: this.title })

        //2原图
        Column(){
          Image(/*$r('app.media.exercise_test1')*/this.submit.submit)
            .width('100%')
        }
        .width('80%')
        .margin({ bottom: 20})

        //3详细字
        Column(){
          Text('可点击下方字查看细致评分')
            .fontSize(14)

          Column(){

            GridRow({
              columns: 8,
              gutter: { x: 2, y: 5 },
              breakpoints: { value: ["400vp", "600vp", "800vp"],
                reference: BreakpointsReference.WindowSize },
              direction: GridRowDirection.Row
            }) {
              ForEach(
                this.Number,
                (number1: number) => {
                  ForEach(
                    this.Number2,
                    (number2: number) => {
                      GridCol(){

                        Column(){
                          Column(){
                            Image(this.word[number1][number2].word/*this.submit.word[number1][number2].word*/)
                              .width('100%')
                              // .height(35)
                          }
                          .width('100%')
                          .constraintSize({ minHeight: 35})
                          .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid })

                          Column(){
                            Text(/*'86'*/`${this.word[number1][number2].strokeNumber}`)
                              .fontSize(12)
                              .fontColor($r('app.color.text_red'))
                          }
                          .width('100%')

                        }
                        .width('100%')
                        .onClick(() => {
                          router.pushUrl(
                            {
                              url: 'pages/exercise/exercise_detail/ExerciseEachWordPage',
                              params: {
                                data: this.word[number1][number2],
                                ifSuccess: 1
                              }
                            }
                          )
                        })

                      }




                    }
                  )
                }
              )

            }

          }
          .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .width('90%')

        Column(){

        }
        .height(50)

      }
      .width('100%')

    }

  }


  onPageShow(){
    const param = router.getParams() as PARAMS

    if (param != null) {
      this.submit = param.submit
    }

    // if (param.submit.word != null  {
    //   this.word = param.submit.word
    // }

  }
}

// 声明接受参数的类型
interface PARAMS {
  submit: SubmitWritingInfo
}