### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 3 – 異常の検出。

## Step 1
このアクティビティでは、作成したデータセットを機械学習アルゴリズムに使用します。アルゴリズムがデータセットの中から異常を検出し、
地図上にマークします。まず、`||loops: 最初だけ||`ブロックの中に`||AI: 機械学習||`ブロックを配置しましょう。

## Step 2
その中に`||Datasets: データセットを入力||`ブロックを配置し、次に`||AI: データを分析||`ブロックを配置しましょう。

## Step 3
これでデータのインポートと分析が完了し、アルゴリズムが結果を出すはずです。結果を地図上で確認できるように、
`||Output: 場所を表示||`ブロックを配置しましょう。


```ghost
Datasets.input_MTB()
AI.analyze_MTB()
Output.showLocations_MTB()
AI.ml_MTB(function() {})
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```