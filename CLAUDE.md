# Minecraft Education Edition 日本語翻訳プロジェクト

## 概要

Minecraft Education Editionのレッスン(.mcworld)を日本語に翻訳するプロジェクト。
ワールド内テキスト(.lang)とMakeCodeチュートリアル(GitHub上のMarkdown)の両方を翻訳する。

## プロジェクト構成

```
minecraft_edu/
├── originals/           # 原本の.mcworldファイル
├── translated/          # 翻訳済み.mcworld（自動生成）
├── scripts/
│   ├── build-mcworld.sh # URL書き換え＋再パッケージ
│   └── lang/            # 事前翻訳済み.langファイル
└── .claude/commands/
    └── translate-mcworld.md  # 翻訳スキル
```

## 外部リポジトリ

- **翻訳テキスト**: https://github.com/0x48lab/minecraft-edu-ja
  - `{lesson-name}/` — チュートリアルMarkdown（日本語）
  - `custom-blocks/` — カスタムブロック定義（日本語）
  - `sources.json` — 元リポジトリとの対応表

## コマンド

```bash
# 翻訳済み.mcworldをビルド
./scripts/build-mcworld.sh "originals/ファイル名.mcworld"
```

## 翻訳の仕組み

1. `.mcworld`（ZIP）内の `.lang` ファイルで NPC名/タイトル/ダイアログ等を翻訳
2. `.mcfunction` 内の `codebuilder navigate` URLを `0x48lab/minecraft-edu-ja` に書き換え
3. GitHub上のMakeCodeチュートリアルMarkdownで コードビルダーUI/説明文を翻訳
4. カスタムブロック定義（TypeScript）で ブロック名を翻訳

## 注意

- MakeCodeチュートリアルのMarkdown内の `ghost`/`template`/`package` ブロックは翻訳しない（関数名はそのまま）
- `§` フォーマットコードは保持
- Minecraft用語は公式日本語訳に準拠
