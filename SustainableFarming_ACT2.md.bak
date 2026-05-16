### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 2 – 宇宙からのデータ。

## Step 1
衛星ビーコンをすべて設置したので、次は衛星を**制御**して、送られてくる情報から**現在の**データセットをコーディングする必要があります。

## Step 2 
まず`||loops: 最初だけ||`ブロックの中に`||Input: 衛星を制御||`ブロックを配置しましょう。その中に`||Datasets: データセットを作成||`ブロックを配置し、`||Datasets: 現在の||`データセットに設定してください。

## Step 2 
次に、すべての`||Input: 場所の衛星データ||`を中に配置しましょう。実行すると、衛星カメラが村の上空をパンしながらデータを収集する様子が見られます。

```ghost
Input.beacon1_SF()
Input.beacon2_SF()
Input.beacon3_SF()
Input.beacon4_SF()
Input.beacon5_SF()
Input.runSatelite_SF(function() {})
Datasets.setOfData_SF(datasetType.historical, function() {})
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja/custom-blocks
```