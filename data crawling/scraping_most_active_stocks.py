import requests
import csv
from bs4 import BeautifulSoup
import pandas as pd
import time

# Scraping Most active stock prices
names=[]
prices=[]
changes=[]
percentChanges=[]
marketCaps=[]
totalVolumes=[]
circulatingSupplys=[]

for i in range(0,10):
  CryptoCurrenciesUrl = "https://finance.yahoo.com/most-active?offset="+str(i)+"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;count=50"
  r= requests.get(CryptoCurrenciesUrl)
  data=r.text
  soup=BeautifulSoup(data, "lxml")

def stock_price_data():
    for listing in soup.find_all('tr', attrs={'class':'simpTblRow'}):

        for name in listing.find_all('td', attrs={"aria-label":"Name"}):
            # print(name.text)
            names.append(name.text)
        for price in listing.find_all('td', attrs={'aria-label':'Price (Intraday)'}):
            # print(price.text)
            # prices.append(price.find('span').text)
            prices.append(price.text)
        for change in listing.find_all('td', attrs={'aria-label':'Change'}):
            # print(change.text)
            changes.append(change.text)
        for percentChange in listing.find_all('td', attrs={'aria-label':'% Change'}):
            # print(percentChange.text)
            percentChanges.append(percentChange.text)
        for marketCap in listing.find_all('td', attrs={'aria-label':'Market Cap'}):
            # print(marketCap.text)
            marketCaps.append(marketCap.text)
        for totalVolume in listing.find_all('td', attrs={'aria-label':'Avg Vol (3 month)'}):
            # print(totalVolume.text)
            totalVolumes.append(totalVolume.text)
        for circulatingSupply in listing.find_all('td', attrs={'aria-label':'Volume'}):
            # print(circulatingSupply.text)
            circulatingSupplys.append(circulatingSupply.text)
    return names, prices, changes, percentChanges, marketCaps, totalVolumes, circulatingSupplys

if __name__ == '__main__':
    latest = 0
    while True:
        stock_price_data() 
        print("starting....")
        cryptoDf = pd.DataFrame({
                            "Names": names, 
                            "Prices": prices, 
                            "Change": changes, 
                            "% Change": percentChanges, 
                            "Market Cap":marketCaps, 
                            "Volume": totalVolumes,
                            "Circulating Supply":circulatingSupplys
                                })
        file_name = f'B:/_GITHUB/virtual-financial-assistant/data crawling/crytoData_{latest}.csv'
        cryptoDf.to_csv(file_name, encoding='utf-8', index=False)
        print("done....")
        repeat_time = 1
        print(f"waiting {repeat_time} minutes...to get new crtyo currency data")
        latest += 1
        time.sleep(repeat_time*60)