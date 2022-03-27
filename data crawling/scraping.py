import requests
import csv
from bs4 import BeautifulSoup
import pandas as pd

# Scraping Crypto Currencies
names=[]
prices=[]
changes=[]
percentChanges=[]
marketCaps=[]
totalVolumes=[]
circulatingSupplys=[]

# for i in range(0,10):
#   CryptoCurrenciesUrl = "https://in.finance.yahoo.com/cryptocurrencies?offset="+str(i)+"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;count=50"
#   r= requests.get(CryptoCurrenciesUrl)
#   data=r.text
#   soup=BeautifulSoup(data, "lxml")


url = 'https://finance.yahoo.com/cryptocurrencies/'
page_html = requests.get(url)
page_html = page_html.text
# print(page_html)
soup = BeautifulSoup(page_html, 'lxml')

# table = soup.find_all('tr', class_ = 'simpTblRow')
# print(len(table))

# table = soup.find_all('tr', attrs={'class':'simpTblRow'})
# print(len(table))
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

cryptocurrenciesDf = pd.DataFrame({"Names": names, "Prices": prices, "Change": changes, "% Change": percentChanges, "Volume": totalVolumes})
print(cryptocurrenciesDf)
        