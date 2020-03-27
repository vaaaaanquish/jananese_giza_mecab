'''
[DATASET]
Wikipedia日英京都関連文書対訳コーパス より5件サンプリング
https://alaginrc.nict.go.jp/WikiCorpus
Creative Comons Attribution-Share-Alike License 3.0
'''

DATASET = [
    ("Worked as a politician of Kizokuin (House of Peers) by recommendation from SAIONJI （Kinmochi), and also succeeded to SAIONJI （Kinmochi)'s passion which was managing and growth of Ritumeikan University.",
     "西園寺の取り立てで貴族院議員として活躍する一方、西園寺の意思を引き継いで発展した立命館大学の運営にも尽力。"),
    ("At that time, Kojurou NAKAGAWA who used work at Specialized academic affairs bureau of Ministry of Education became the secretary of SAIONJI who was minister of education.",
     "当時、文部省専門学務局勤務から文部大臣秘書官として西園寺文部大臣直属となった中川小十郎が、京都帝国大学初代事務局長に任命され大学業務を総括。"),
    ("The first principal was the professor of Tokyo Teikoku University Masaakira TOMII who was one of the members that drafted the civil law.",
     "初代校長には、民法起草者の一人で東京帝国大学教授の富井政章が就任した。"), ("Establishment of Kyoto Hosei School", "京都法政学校の設立"),
    ("School was established for worker's education as a night school (three years), there was the student who was the government officer, prefecture school teacher, prefecture worker who had honorable position.",
     "社会人教育を目的に夜間学校（三年制）として設立されたため、学生には官庁職員、府立学校教諭、府の名誉職にあるものなどが多く含まれていた。")
]

import MeCab


def make_mecab_tagger():
    try:
        return MeCab.Tagger(f'-Owakati --dicdir=/usr/lib/mecab/dic/mecab-ipadic-neologd')
    except FileNotFoundError:
        return


def tokenize_japanese(text):
    mecab = make_mecab_tagger()
    return mecab.parse(text)


if __name__ == '__main__':
    """"enとjaファイルのサンプルを生成"""
    with open('en', 'w') as fe:
        with open('ja', 'w') as fj:
            for e, j in DATASET:
                fe.write(e.lower() + '\n')
                fj.write(tokenize_japanese(j) + '\n')
