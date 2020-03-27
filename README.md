# jananese_giza_mecab
統計的機械翻訳におけるアライメントツールGIZA++を利用するため、日本語に対してmecab、neologdを動かすdockerとexample

# Usage

docker buildでGIZA++、Python (pyenv)、MeCab、ipadic-neologdが入ったUbuntu環境ができる。
```
# build
docker build giza .

# run
docker run -it giza
```

## example

以下のサンプルを含む。

 - mecab_tokenize_example.py : mecabの辞書が扱えている事を確認する
 - make_example_data.py : GIZA++サンプル用の小さなデータ(en, ja)をmecabを使って生成する
 - train.sh : GIZA++を学習させる

### mecab、neologdの確認

```
python mecab_tokenize_example.py

# neologd true: neologd は 中居正広の金曜日のスマイルたちへ を 1つ の 単語 と し ます
# neologd false: neologd は 中居 正広 の 金曜日 の スマイル たち へ を 1つ の 単語 と し ます
```

### GIZA++を動かす

最小の学習データを生成する。英語(小文字化処理済み)と日本語(parse済み)のファイルがenとjaという名前で出力される。
```
python make_example_data.py
```

GIZA++を動かす。上記コマンドで生成したen、jaを入力としている。フォーマットなどはen、jaを参照。
```
./train.sh
```

以下のようにファイルが出力される。
```
root@5608d61af3d6:~# ls -l
total 120
2020-03-27.043534.Anything.A3.final
2020-03-27.043534.Anything.D4.final
2020-03-27.043534.Anything.Decoder.config
2020-03-27.043534.Anything.a3.final
2020-03-27.043534.Anything.d3.final
2020-03-27.043534.Anything.d4.final
2020-03-27.043534.Anything.gizacfg
2020-03-27.043534.Anything.n3.final
2020-03-27.043534.Anything.p0_3.final
2020-03-27.043534.Anything.perp
2020-03-27.043534.Anything.t3.final
2020-03-27.043534.Anything.trn.src.vcb
2020-03-27.043534.Anything.trn.trg.vcb
2020-03-27.043534.Anything.tst.src.vcb
2020-03-27.043534.Anything.tst.trg.vcb
```

以下の3つのファイルが最終的な単語ID、頻度、尤度になっているので翻訳等に利用できる。
- *.t3.final
- *.trn.src.vcb
- *.trn.trg.vcb 


# Reference
参考文献。Mosesも含む。

 - GIZA++の実行、解説
    - GIZA++ の使い方 how-to-use-giza-pp.md - mosmeh https://gist.github.com/mosmeh/80f239f7372e4caf87bf
    - Mosesの後輩への引き継ぎのためのまとめ - kanjirz50 https://qiita.com/kanjirz50/items/c8ca50466b57a619e2a2
    - Phrase-base Statistical Machine Translation - 中澤 敏明 https://slidesplayer.net/slide/14610301/
    - Using GIZA++ http://wiki.apertium.org/wiki/Using_GIZA%2B%2B
	- Using GIZA++ to Obtain Word Alignment Between Bilingual Sentences - Masato Hagiwara https://masatohagiwara.net/using-giza-to-obtain-word-alignment-between-bilingual-sentences.html
	- 統計的機械翻訳ツールキットcicada - 自然言語処理 on Mac https://hjym-u.hatenadiary.org/entry/20131102/1383383771
	- 「音声言語処理と自然言語処理」演習 - 土屋 雅稔，山本 一公 httpsoronasha.co.jp/np/data/docs1/978-4-339-02888-1_2.pdf
    - ニューラル機械翻訳の動向@IBIS2017 - Toshiaki Nakazawa https://www.slideshare.net/ToshiakiNakazawa/ibis2017
 - 拡張
    - 単語境界が明示されていない言語を対象とした対訳辞書の自動構築 - 北陸先端科学技術大学院大学情報科学研究科 王 馨竹 https://dspace.jaist.ac.jp/dspace/bitstream/10119/14172/5/paper.pdf
	- HMM Word and Phrase Alignment for Statistical Machine Translation - Yonggang Deng http://www.mt-archive.info/HLT-EMNLP-2005-Deng.pdf
    - Bayesian Subtree Alignment Model based on Dependency Trees - Toshiaki Nakazawa https://www.aclweb.org/anthology/I11-1089.pdf
