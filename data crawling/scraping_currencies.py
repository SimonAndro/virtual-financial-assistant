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

# currenciesUrl = "https://finance.yahoo.com/cryptocurrencies"
# r = requests.get(currenciesUrl)
# data=r.text
# soup=BeautifulSoup(data, "lxml")

currenciesUrl = 'https://finance.yahoo.com/cryptocurrencies/'
page_html = requests.get(currenciesUrl)
page_data = page_html.text
soup = BeautifulSoup(page_data, 'lxml')

def currencyData():
    for listing in soup.find_all('tr', attrs={'class':'simpTblRow'}):
        # print(listing.text)
        for name in listing.find_all('td', attrs={"aria-label":"Name"}):
        #     print(name.text)
            names.append(name.text)
        # for price in listing.find_all('td', attrs={'aria-label':'Last Price'}):
        #     print(price.find('span').text)
    #         # prices.append(price.find('span').text)
    #         prices.append(price.text)
        for change in listing.find_all('td', attrs={'aria-label':'Change'}):
            # print(change.text)
            changes.append(change.text)
    #     for percentChange in listing.find_all('td', attrs={'aria-label':'% Change'}):
    #         # print(percentChange.text)
    #         percentChanges.append(percentChange.text)
    #     for marketCap in listing.find_all('td', attrs={'aria-label':'Market Cap'}):
    #         # print(marketCap.text)
    #         marketCaps.append(marketCap.text)
    #     for totalVolume in listing.find_all('td', attrs={'aria-label':'Total Volume All Currencies (24Hr)'}):
    #         # print(totalVolume.text)
    #         totalVolumes.append(totalVolume.text)
    #     for circulatingSupply in listing.find_all('td', attrs={'aria-label':'Circulating Supply'}):
    #         # print(circulatingSupply.text)
    #         circulatingSupplys.append(circulatingSupply.text)
    # return names, prices, changes, percentChanges, marketCaps, totalVolumes, circulatingSupplys

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
    # latest = 0
    # while True:
    #     cryptoData() 
    #     print("starting....")
    #     cryptoDf = pd.DataFrame({
    #                         "Names": names, 
    #                         "Prices": prices, 
    #                         "Change": changes, 
    #                         "% Change": percentChanges, 
    #                         "Market Cap":marketCaps, 
    #                         "Volume": totalVolumes,
    #                         "Circulating Supply":circulatingSupplys
    #                             })
    #     file_name = f'B:/_GITHUB/virtual-financial-assistant/data crawling/crytoData_{latest}.csv'
    #     cryptoDf.to_csv(file_name, encoding='utf-8', index=False)
    #     print("done....")
    #     repeat_time = 10
    #     print(f"waiting {repeat_time} minutes...to get new crtyo currency data")
    #     latest += 1
    #     time.sleep(repeat_time*60)
    currencyData()