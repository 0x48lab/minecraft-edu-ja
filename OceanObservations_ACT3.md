### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 3 – 未来に備える。

## Step 1
安定したデータストリームが入ってきているので、気候変動がサンゴ礁に与える影響の研究を始められます。ただし、
センサーが故障するたびに水中に潜りたくはありません。AIを使えば、収集中のライブデータを使った
**自律ナビゲーション**でエージェントがセンサーに到達して自動修理できるようにコーディングできます。

## Step 2 
`||loops: 最初だけ||`ブロックの中に`||AI: 機械学習||`ブロックを配置しましょう。
その中に`||Datasets: データセットを入力||`ブロックを配置し、`||datasets: ライブデータセット||`に設定してください。
その後、`||AI: 地形データを分析||`ブロックを配置します。

## Step 3
次に`||AI: ルートを生成||`ブロックを配置しましょう。
実行すると、AIがエージェントのルートを生成し、サンゴに衝突しないようにします。
また、海底の地形をマップ上で確認できるようになります。

```ghost
AI.analyze_OO()
AI.ml_OO(function() {})
Datasets.input_OO()
AI.genRoutes_OO()
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```