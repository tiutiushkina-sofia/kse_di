import pandas as pd
import matplotlib.pyplot as plt

dff = pd.read_csv('/Users/sofiatiutiuskina/popular_restaurants.csv', names = ['name', 'city', 'stars', 'review_count', 'is_open', 'wifi', 'rank'])
plt.figure(figsize=(10,10))
dff['label'] = dff['name'] +'(' + dff['city'] + ')'
plt.bar(dff['label'], dff['review_count'])
plt.title('Top 15 restaurants')
plt.xlabel('Review Count')
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig('/Users/sofiatiutiuskina/Downloads/top.png')
plt.show()