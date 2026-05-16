### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 3 – プロのトラッカー

## Step 1
次に、オセロットを追跡するAIをコーディングしましょう。
サバンナから届く**現在の**データを使い、
前のアクティビティでまとめた**過去の**データセットと**比較**します。

## Step 2
まず `||AI: 半教師あり機械学習||` コーディングブロックを使い、その中に `||Datasets: データセットを入力||` コーディングブロックを配置します。
その後、`||Datasets: データセットを比較||` コーディングブロックを配置します。**現在の**データセットと**過去の**データセットを設定してください。

## Step 3
次に `||AI: パターンデータを分析||` コーディングブロックを配置します。続けて `||Output: オセロットを探す||` コーディングブロックを配置します。
コードを実行すると、オセロットの位置を示す地図が表示されます。

```ghost
Datasets.compare_PR()
Datasets.input_PR()
AI.ml_PR(function(){})
AI.analyze_PR()
Output.locateOcelots_PR()
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```
