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

def currencyToData():
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
        for percentChange in listing.find_all('td', attrs={'aria-label':'% Change'}):
            # print(percentChange.text)
            percentChanges.append(percentChange.text)
    
# currencyToData()
# currencytoDf = pd.DataFrame({
#                          "Names": names, 
#                         "Prices": prices, 
#                         "Change": changes, 
#                         "% Change": percentChanges,                     
#                         })

# saving the cryptoData to csv
# file_name = 'B:/_GITHUB/virtual-financial-assistant/data crawling/crytoData.csv'
# currencytoDf.to_csv(file_name, encoding='utf-8', index=False)

# repeat the process
if __name__ == '__main__':
    latest = 0
    while True:
        currencyToData() 
        print("starting....")
        currencytoDf = pd.DataFrame({
                        "Names": names, 
                        # "Prices": prices, 
                        "Change": changes, 
                        "% Change": percentChanges,                     
                                                    })
        file_name = f'B:/_GITHUB/virtual-financial-assistant/data crawling/currency data {latest}.csv'
        currencytoDf.to_csv(file_name, encoding='utf-8', index=False)
        print("done....")
        repeat_time = 10
        print(f"waiting {repeat_time} minutes...to get new currency data")
        latest += 1
        time.sleep(repeat_time*60)