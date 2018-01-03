# -*- encoding:utf-8 -*-
import json
import os

from aylienapiclient import textapi
from pyteaser import Summarize, keywords5

client = textapi.Client("1808166e", "16c6e9275d7a517192b517abe12c9b35")


def single_txt(txtname):
    code = 0
    message = "success"
    title = ""
    time = ""
    text = ""

    f2 = open(txtname)
    i = 0
    while 1:
        line = f2.readline()
        if not line:
            break
        if i == 0:
            title = line
        if i == 1:
            time = line
        if i >= 2:
            text = text + line
        i = i + 1

    if i < 2:
        code = 1
        message = "wrong format"
    key2 = keywords5(text)
    # pprint(key2)
    summaries = Summarize(title, text)
    # pprint(summaries)
    abstract = ''
    for summary in summaries:
        abstract = abstract + summary + " "

    sentimentstr = client.Sentiment({'text': text})
    sentiment = sentimentstr['polarity_confidence']
    positive = sentimentstr['polarity']
    if positive == 'positive':
        sentiment = abs(sentiment - 0.5) * 2 * 0.8 + 0.2
    if positive == 'negative':
        sentiment = -(abs(sentiment - 0.5) * 2 * 0.8 + 0.2)
    if positive == 'neutral':
        if len(text) % 2 == 1:
            sentiment = (0.2 - abs(sentiment - 0.5) * 2 * 0.2)
        else:
            sentiment = -(0.2 - abs(sentiment - 0.5) * 2 * 0.2)

    data = {
        'title': title.strip('\n'),
        'time': time.strip('\n'),
        'abstract': abstract,
        'keywords': key2,
        'sentiment': sentiment
    }
    return code, message, data


if __name__ == '__main__':
    while True:
        file = raw_input()
        try:
            code, message, data = single_txt(file)
        except Exception:
            code = -1
            message = 'Unknown Error.'
            data = []
        if code == 0:
            print(json.dumps({'code': 0, 'name': os.path.basename(file), 'data': data}, ensure_ascii=False))
        else:
            print(json.dumps({'code': code, 'name': os.path.basename(file), 'message': message}, ensure_ascii=False))
