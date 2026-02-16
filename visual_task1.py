import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('/Users/sofiatiutiuskina/accessible_top10.csv', names = ['city', 'all_businesses', 'accessible_businesses', 'ratio'])
df['percent'] = (df['ratio']*100).round(2)
plt.figure(figsize=(10,10))
chart = plt.bar(df['city'], df['percent'])
plt.title('Top 10 businesses by accessibility')
plt.xlabel('City')
plt.ylabel('Percentage')
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig('/Users/sofiatiutiuskina/Downloads/top10.png')
plt.show()


