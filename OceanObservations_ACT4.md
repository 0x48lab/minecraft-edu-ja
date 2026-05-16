### @codeStart players set @s makecode 0
### @codeStop players set @s makecode 1

```template
//
```

### @explicitHints true
### @flyoutOnly 0
### @hideIteration true 

# アクティビティ 4 – テストしてみよう。

## Step 1
AIが生成したルートが正しいか確認する必要があります。`||loops: 最初だけ||`ブロックの中に`||AI: 自律ナビゲーションアルゴリズム||`
ブロックを配置しましょう。その中に、`||Output: 出力||`タブにあるブロックを使って
エージェントが到達すべきセンサーを指定してください。エージェントが到達する必要があるセンサーは**2**と**4**です。

```ghost
AI.ml_OO2(function(){})
Output.reach1_OO()
Output.reach2_OO()
Output.reach3_OO()
Output.reach4_OO()
```

```package
aicustomblocks=github:0x48lab/minecraft-edu-ja-blocks
```