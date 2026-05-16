### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 3 – あちこちに汚染物質。

## Step 1
汚染源を見つけるAIをコーディングする必要があります。前のアクティビティでコーディングした**現在の**データセットを
**分析**して、汚染物質の濃度が最も高い場所を特定しましょう。

## Step 2
まず`||AI: 教師あり機械学習||`ブロックを使い、その中に`||Datasets: データセットを入力||`ブロックを配置して、**現在の**に設定しましょう。

## Step 3
次に`||AI: 水質データを分析||`ブロックを配置し、続けて`||Output: 汚染源を特定||`ブロックを配置しましょう。
コードを実行すると、AIが汚染の発生源を特定します。

```ghost
Datasets.input_WQ()
AI.ml_WQ(function(){})
AI.analyze_WQ()
Output.locatePollution_WQ()
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```