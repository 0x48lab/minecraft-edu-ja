### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 2 – パターン、パターン、パターン...

## Step 1
さまざまなオセロットの模様の写真データを大量に集めたので、データセットにコーディングしましょう。
 
## Step 2 
まず `||Datasets: データセットを作成||` コーディングブロックを使い、`||Datasets: 過去の||` に設定します。その中に、先ほど集めた `||Input: カメラトラップのデータ||` をすべて配置してください。

## Step 3 
最後のステップとして、写真データからオセロットの模様のパターンを抽出する必要があります。`||Datasets: パターンを抽出||` コーディングブロックを使いましょう。
コードを実行すると、オセロットのパターンのプレビューがコンパイルされます。

```ghost
Input.trap1_PR()
Input.trap2_PR()
Input.trap3_PR()
Datasets.extractPatterns_PR()
Datasets.setOfData_PR(datasetType.historical, function() {})
```

```package
aicustomblocks=github:fountainstudios/AICustomBlocks
```
