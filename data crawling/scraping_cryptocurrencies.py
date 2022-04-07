import requests
import csv
from bs4 import BeautifulSoup
import pandas as pd
import time

# Scraping Crypto Currencies
names=[]
prices=[]
changes=[]
percentChanges=[]
marketCaps=[]
totalVolumes=[]
circulatingSupplys=[]

for i in range(0,10):
  CryptoCurrenciesUrl = "https://finance.yahoo.com/cryptocurrencies?offset="+str(i)+"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;count=50"
  r= requests.get(CryptoCurrenciesUrl)
  data=r.text
  soup=BeautifulSoup(data, "lxml")


# url = 'https://finance.yahoo.com/cryptocurrencies/'
# page_html = requests.get(url)
# page_html = page_html.text
# soup = BeautifulSoup(page_html, 'lxml')

def cryptoData():
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
        for totalVolume in listing.find_all('td', attrs={'aria-label':'Total Volume All Currencies (24Hr)'}):
            # print(totalVolume.text)
            totalVolumes.append(totalVolume.text)
        for circulatingSupply in listing.find_all('td', attrs={'aria-label':'Circulating Supply'}):
            # print(circulatingSupply.text)
            circulatingSupplys.append(circulatingSupply.text)
    return names, prices, changes, percentChanges, marketCaps, totalVolumes, circulatingSupplys

# cryptoData()
# cryptoDf = pd.DataFrame({"Names": names, 
#                         "Prices": prices, 
#                         "Change": changes, 
#                         "% Change": percentChanges, 
#                         "Market Cap":marketCaps, 
#                         "Volume": totalVolumes,
#                         "Circulating Supply":circulatingSupplys
#                         })

# saving the cryptoData to csv
# file_name = 'B:/_GITHUB/virtual-financial-assistant/data crawling/crytoData.csv'
# cryptoDf.to_csv(file_name, encoding='utf-8', index=False)

# repeat the process
if __name__ == '__main__':
    latest = 0
    while True:
        cryptoData() 
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
        file_name = f'B:/_GITHUB/virtual-financial-assistant/data crawling/crypocurrency data {latest}.csv'
        cryptoDf.to_csv(file_name, encoding='utf-8', index=False)
        print("done....")
        repeat_time = 10
        print(f"waiting {repeat_time} minutes...to get new cryptocurrency data")
        latest += 1
        time.sleep(repeat_time*60)