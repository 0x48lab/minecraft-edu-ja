# Minecraft Education Edition - 日本語翻訳

Minecraft Education Editionのレッスンワールド(.mcworld)を日本語に翻訳するプロジェクトです。

**ダウンロードサイト**: https://0x48lab.github.io/minecraft-edu-ja/

## 翻訳範囲

1つの`.mcworld`に対して、以下の **すべて** を日本語化します。

| 対象 | 内容 | 保存先 |
|------|------|--------|
| ワールド内テキスト | NPC名・ダイアログ、タイトル、アクションバー、看板、ボードテキスト | `.lang` ファイル |
| MakeCodeチュートリアル | コードビルダー上部の説明文（手順テキスト） | このリポジトリの `{lesson}/` |
| カスタムブロック | MakeCodeのブロック名・カテゴリ名・enum値 | このリポジトリの `custom-blocks/` |
| MakeCode URL | mcfunction内のチュートリアル参照先 | mcfunction内で書き換え |

## 翻訳のやり方（Claude Code スキル）

### 前提

- Claude Code がインストールされていること
- `minecraft_edu/` プロジェクトで作業すること
- `originals/` に翻訳したい `.mcworld` ファイルを配置しておくこと

### 手順

1. `originals/` に翻訳対象の `.mcworld` ファイルを置く
2. Claude Code で以下を実行する：

```
/translate-mcworld AI Pattern Recognition.mcworld
```

3. スキルが自動で以下を実行する：
   - `.mcworld` を展開し、英語テキストを抽出
   - `.lang` ファイル（NPC、タイトル、ダイアログ等）を日本語に翻訳
   - MakeCode チュートリアルのMarkdownをGitHubから取得し、日本語に翻訳
   - カスタムブロック定義（TypeScript）のブロック名を日本語化
   - 翻訳済みファイルをこのリポジトリ（`0x48lab/minecraft-edu-ja`）にコミット・プッシュ
   - mcfunction内のMakeCode URLを翻訳リポジトリに書き換え
   - `docs/worlds.json` にエントリを追加（GitHub Pages検索対象に登録）
   - `translated/` に翻訳済み `.mcworld` を出力
   - GitHub Releasesに `.mcworld` をアップロード

4. 完了すると、以下が更新される：
   - https://0x48lab.github.io/minecraft-edu-ja/ にワールドカードが追加される
   - ダウンロードボタンからすぐに `.mcworld` を取得できる

### 引数なしで実行した場合

```
/translate-mcworld
```

`originals/` 内のファイル一覧が表示され、翻訳対象を選択できます。

## ローカルプロジェクト構成

```
minecraft_edu/
├── originals/                     # 原本の.mcworldファイル（手動配置）
├── translated/                    # 翻訳済み.mcworld（自動生成）
├── scripts/
│   ├── build-mcworld.sh           # URL書き換え＋再パッケージ
│   └── lang/                      # 事前翻訳済み.langファイル
│       ├── texts/ja_JP.lang
│       ├── behavior_packs/bp0/texts/ja_JP.lang
│       └── resource_packs/rp0/texts/ja_JP.lang
├── .claude/commands/
│   └── translate-mcworld.md       # 翻訳スキル定義
└── CLAUDE.md
```

## GitHubリポジトリ構成

```
0x48lab/minecraft-edu-ja/
├── {lesson-name}/                 # レッスンごとのMakeCodeチュートリアル（日本語）
│   ├── *_ACT1.md ... *_ACT4.md
│   ├── noCodingRequired.md
│   ├── tutorialDone.md
│   └── pxt.json
├── custom-blocks/                 # カスタムブロック定義（日本語）
│   ├── AIBlocks.ts
│   └── pxt.json
├── docs/                          # GitHub Pages
│   ├── index.html                 # ダウンロードサイト
│   └── worlds.json                # ワールドメタデータ（検索・フィルタ用）
├── sources.json                   # 元リポジトリとの対応表
└── README.md
```

## 翻訳の仕組み（詳細）

### .lang ファイル

Minecraft Bedrock Editionのローカライゼーション機構を利用。`en_US.lang` に対応する `ja_JP.lang` を追加し、`languages.json` に `ja_JP` を登録します。ゲーム言語が日本語の場合、自動的に `ja_JP.lang` のテキストが使われます。

```
# en_US.lang
NPC.name.activity1=Activity 1 - Biologist

# ja_JP.lang
NPC.name.activity1=アクティビティ 1 - 生物学者
```

### MakeCode チュートリアル

`.mcfunction` 内の `codebuilder navigate` コマンドが、MakeCodeのチュートリアルURLを指定しています。

```
# 元のURL
codebuilder navigate @a false https://minecraft.makecode.com/...#tutorial:github:fountainstudios/aimakecodemarkdown/PatternRecognition_ACT2

# 翻訳後のURL
codebuilder navigate @a false https://minecraft.makecode.com/...#tutorial:github:0x48lab/minecraft-edu-ja/ai-pattern-recognition/PatternRecognition_ACT2
```

チュートリアルMarkdownのStep説明文とタイトルを日本語化し、このリポジトリにホストします。

### カスタムブロック

MakeCodeの拡張機能として定義されたカスタムブロック（TypeScript）の `//% block="..."` アノテーションを日本語化します。

```typescript
// 元
//% block="extract patterns"
export function extractPatterns_PR() { ... }

// 翻訳後
//% block="パターンを抽出"
export function extractPatterns_PR() { ... }
```

関数名は変更しません（Markdownの `ghost`/`template` ブロックから参照されるため）。

## 翻訳ガイドライン

- Minecraft公式用語は日本語版に準拠（ocelot → オセロット 等）
- `§` フォーマットコード（色・太字）はそのまま保持
- mcfunctionのコマンド構文は変更しない
- MakeCodeアノテーション（`@codeStart`, `@codeStop`, `@explicitHints` 等）はそのまま保持
- `ghost` / `template` / `package` コードブロック内の関数名はそのまま保持
- MakeCodeブロック参照（`||Category: block name||`）は翻訳後のブロック名に合わせる

## 翻訳済みワールド

| ワールド | 教科 | 状態 |
|----------|------|------|
| AI Pattern Recognition | AI・機械学習 | 翻訳済み |

## ライセンス

翻訳コンテンツの著作権は原著作者に帰属します。
