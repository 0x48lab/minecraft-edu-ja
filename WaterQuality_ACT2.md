### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 2 – 蛇口から直接。

## Step 1
周辺の川から水サンプルを採取したので、各場所の水データを使って**現在の**データセットをコーディングしましょう。

## Step 2 
まず`||Datasets: データセットを作成||`ブロックを使い、`||Datasets: 現在の||`に設定しましょう。その中に、各場所の`||Input: 水質データ||`
をすべて配置してください。

```ghost
Input.waterData1_WQ()
Input.waterData2_WQ()
Input.waterData3_WQ()
Datasets.setOfData_WQ(datasetType.historical, function() {})
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```