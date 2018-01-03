# -*- coding: utf-8 -*-
from __future__ import print_function
from __future__ import unicode_literals

from snownlp import normal
from snownlp import seg
from snownlp.summary import textrank
from snownlp import SnowNLP
import sys
import os
import os.path
import json

default_encoding = 'utf-8'
if sys.getdefaultencoding() != default_encoding:
    reload(sys)
    sys.setdefaultencoding(default_encoding)


def get_list_files(fold):
    ret = []
    a = []
    for root, dirs, files in os.walk(fold):
        for filespath in files:
            ret.append(os.path.join(root, filespath))
            a.append(filespath)
    return a


def get_json(path):
    result = {}
    try:
        count = 0
        code = 0
        message = 'success'
        content = u''
        title = ''
        time = ''
        abstract = ''
        # ========================================
        #    读取文件的时间、标题、内容
        # ========================================
        for line in open(path, 'r'):
            if count == 0:
                title = line
                count += 1
                # print (title)
                continue
            if count == 1:
                time = line
                count += 1
                # print (time)
                continue
            if count > 1:
                count += 1
                content += line
                # print (line)

        # ========================================
        #      生成摘要
        # =======================================
        t = normal.zh2hans(content)
        sents = normal.get_sentences(t)
        doc = []
        for sent in sents:
            words = seg.seg(sent)
            words = normal.filter_stop(words)
            doc.append(words)
        rank = textrank.TextRank(doc)
        rank.solve()
        for index in rank.top_index(5):
            abstract = abstract + sents[index] + ' '
        keyword_rank = textrank.KeywordTextRank(doc)
        keyword_rank.solve()
        word0 = {}
        word1 = {}
        word2 = {}
        word3 = {}
        word4 = {}
        wordcount = 0
        for w in keyword_rank.top_index(5):
            if wordcount == 0:
                word0["word"] = w
                word0["frequency"] = float(content.count(w)) / float(len(content))

            if wordcount == 1:
                word1["word"] = w
                word1["frequency"] = float(content.count(w)) / float(len(content))
            if wordcount == 2:
                word2["word"] = w
                word2["frequency"] = float(content.count(w)) / float(len(content))
            if wordcount == 3:
                word3["word"] = w
                word3["frequency"] = float(content.count(w)) / float(len(content))
            if wordcount == 4:
                word4["word"] = w
                word4["frequency"] = float(content.count(w)) / float(len(content))
            wordcount += 1

        s = SnowNLP(content)
        score = (s.sentiments - 0.5) * 2  # -1-1规范化

        keywords = [word0, word1, word2, word3, word4]
    except IOError:
        code = 1
        message = "wrong format"

    result["title"] = title.strip()
    result["time"] = time.strip()
    result['abstract'] = abstract
    result['sentiment'] = score
    result["keywords"] = keywords

    return code, message, result


if __name__ == '__main__':
    while True:
        file = raw_input()
        try:
            code, message, data = get_json(file)
        except Exception:
            code = -1
            message = 'Unknown Error.'
            data = []
        if code == 0:
            print(json.dumps({'code': 0, 'name': os.path.basename(file), 'data': data}, ensure_ascii=False))
        else:
            print(json.dumps({'code': code, 'name': os.path.basename(file), 'message': message}, ensure_ascii=False))
