### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0

# アクティビティ 2 – すべてをマッピングする。

## Step 1
このアクティビティでは、撮影したすべての写真を1つの大きな`||datasets: データセット||`にまとめます。すべてのデータがコンパイルされ、
森全体の大きな地図として表示されます。まず、`||loops: 最初だけ||`ブロックの中に`||datasets: データセットを作成||`ブロックを配置しましょう。

## Step 2
`||datasets: データセットを作成||`ブロックの中に、**3つ**の場所から撮影した**すべて**のデータを配置しましょう。`||Input: 写真データ||`
ブロックは`||Input: 入力||`タブにあります。

```ghost
Input.location1PictureData_MTB()
Input.location2PictureData_MTB()
Input.location3PictureData_MTB()
Datasets.setOfData_MTB(function() {})
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja/custom-blocks
```