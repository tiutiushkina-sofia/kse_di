CREATE TABLE city_business AS
SELECT * FROM read_json_auto('/Users/sofiatiutiuskina/Downloads/yelp_academic_dataset_business.json')

CREATE TABLE business_flat AS
    SELECT business_id, name, address, city, state, postal_code, latitude, longitude, stars, review_count, is_open,
       attributes.*, hours.*
    FROM city_business;

CREATE TABLE business_categories AS
    SELECT business_id, name, TRIM(UNNEST(STR_SPLIT(categories, ', '))) AS category FROM city_business;

SELECT bf.name, bf.city, bf.stars, bf.review_count, bf.is_open, bf.WIFI,
       ROW_NUMBER() OVER(
       PARTITION BY bf.city
       ORDER BY bf.stars DESC, bf.review_count DESC
       ) AS rank
FROM business_flat AS bf
JOIN business_categories AS bc ON bf.business_id = bc.business_id
WHERE bf.is_open = 1  AND bf.WIFI LIKE '%free%' AND bc.category = 'Restaurants'
QUALIFY rank = 1
ORDER BY review_count DESC
LIMIT 15;
-- тут видається корисна інформація для туристіків - найпопулярніші відкриті ресторани з найвищими оцінками,
-- першими видаються ресторани з найбільшою кількістю відгуків та з найвищими оцінками

SELECT city,
    COUNT(*) AS all_businesses,
    COUNT(CASE WHEN WheelchairAccessible = 'True' THEN 1 END) AS accessible,
    COUNT(CASE WHEN WheelchairAccessible = 'True' THEN 1 END)/COUNT(*) AS perc_accessible
FROM business_flat
WHERE is_open = 1
GROUP BY city
HAVING COUNT(*) > 50
ORDER BY perc_accessible DESC
LIMIT 10;
-- тут ми будуємо рейтинг доступних міст базуючись на співвідношенні бізнесів доступних для людей на кріслах колісних до усіх бізнесів міста
-- рахуємо відсотково та не беремо до уваги села з одним доступним ларьком як найдоступніші міста - мінімум 50 бізнесів
