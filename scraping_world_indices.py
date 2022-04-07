import requests
import csv
from bs4 import BeautifulSoup
import pandas as pd
import time

# Scraping World index
names=[]
prices=[]
changes=[]
percentChanges=[]
marketCaps=[]
totalVolumes=[]
circulatingSupplys=[]

worldIndicesUrl = 'https://finance.yahoo.com/world-indices/'
page_html = requests.get(worldIndicesUrl)
page_data = page_html.text
soup = BeautifulSoup(page_data, 'lxml')

def world_indices_data():
    for listing in soup.find_all('tr', attrs={'class':'simpTblRow'}):

        for name in listing.find_all('td', attrs={"aria-label":"Name"}):
            # print(name.text)
            names.append(name.text)
        for price in listing.find_all('td', attrs={'aria-label':'Last Price'}):
            # print(price.text)
            # prices.append(price.find('span').text)
            prices.append(price.text)
        for change in listing.find_all('td', attrs={'aria-label':'Change'}):
            # print(change.text)
            changes.append(change.text)
        for percentChange in listing.find_all('td', attrs={'aria-label':'% Change'}):
            # print(percentChange.text)
            percentChanges.append(percentChange.text)
        for totalVolume in listing.find_all('td', attrs={'aria-label':'Volume'}):
            # print(totalVolume.text)
            totalVolumes.append(totalVolume.text)
    return names, prices, changes, percentChanges, totalVolumes

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
                            "Volume": totalVolumes,
                            })
        file_name = f'B:/_GITHUB/virtual-financial-assistant/data crawling/crytoData_{latest}.csv'
        cryptoDf.to_csv(file_name, encoding='utf-8', index=False)
        print("done....")
        repeat_time = 1 # {1:1 minute; 2: 2 minutes ... n: n minutes}
        print(f"waiting {repeat_time} minutes...to get new crtyo currency data")
        latest += 1
        time.sleep(repeat_time*60)