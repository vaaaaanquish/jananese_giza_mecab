import MeCab


def make_mecab_tagger(neologd=True):
    try:
        if neologd:
            return MeCab.Tagger(f'-Owakati --dicdir=/usr/lib/mecab/dic/mecab-ipadic-neologd')
        else:
            return MeCab.Tagger(f'-Owakati')
    except FileNotFoundError:
        return


def tokenize_japanese(text, neologd=True):
    mecab = make_mecab_tagger(neologd)
    return mecab.parse(text)


if __name__ == '__main__':
    sample_text = "neologdは中居正広の金曜日のスマイルたちへを1つの単語とします"
    print('neologd true:', tokenize_japanese(sample_text, True))
    print('neologd false:', tokenize_japanese(sample_text, False))
