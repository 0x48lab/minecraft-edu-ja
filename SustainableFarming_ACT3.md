### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 3 – 予測分析。

## Step 1
最適な栽培場所を見つけるAIをコーディングしましょう。
前のアクティビティで作成した**現在の**データセットを使い、
衛星ステーションが既に持っている**過去の**データセットと**比較**します。

## Step 2
まず`||AI: 半教師あり機械学習||`ブロックを使い、その中に`||Datasets: データセットを入力||`ブロックを配置しましょう。
その後、`||Datasets: データセットを比較||`ブロックを配置してください。**現在の**データセットと**過去の**データセットに設定します。

## Step 3
次に`||AI: 予測分析を実行||`ブロックを配置し、続けて`||Output: 最適な農地を見つける||`ブロックを配置しましょう。
コードを実行すると、AIが最適な農地を見つけてライトアップします。

```ghost
Datasets.compare_SF()
Datasets.input_SF()
AI.ml_SF(function(){})
AI.analyze_SF()
Output.locateFarm_SF()
```

```package
aicustomblocks=github:fountainstudios/AICustomBlocks
```