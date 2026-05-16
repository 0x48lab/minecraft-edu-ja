### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 2 – 水中データ。

## Step 1
センサーを設置したので、**4つ**のセンサーからのすべてのデータを保持する**1つ**のライブデータセットを作る必要があります。
これが完了すると、4つのモニターで水面下の様子をマッピングして見ることができます。

## Step 2 
まず`||loops: 最初だけ||`ブロックの中に`||Datasets: データセットを作成||`ブロックを配置しましょう。
`||Datasets: ライブ||`データセットに設定してください。

## Step 3
次に、`||Input: センサーデータ||`をデータセットの中に配置しましょう。

```ghost
Input.sensor1_OO()
Input.sensor2_OO()
Input.sensor3_OO()
Input.sensor4_OO()
Datasets.setOfData_OO(datasetType.historical, function() {})
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```