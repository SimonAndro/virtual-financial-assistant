import csv, io
import pandas as pd
from werkzeug import Request

def cryptoDict():
    df = pd.read_csv("../static/data/crytoData_4.csv")
    # df = pd.read_csv("{% static 'data/crytoData_4.csv' %}")
    # data = csv.reader(request.FILES['file'])
    # file = csv.reader('cryptoData_4.csv')
    # print(df.head())
    # df = pd.read_csv(file)
    crypto_dict = df.to_dict()
    #print(crypto['Names'])
    return crypto_dict

if __name__ == '__main__':
    d = cryptoDict()
    print(d['Names'])
    

