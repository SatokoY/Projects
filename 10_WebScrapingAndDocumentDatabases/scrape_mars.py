from splinter import Browser
from bs4 import BeautifulSoup
import pandas as pd
import requests

def init_browser():

    # Set the executable path 
    executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
    return Browser('chrome', **executable_path, headless=False)

# Create mission to mars dictionary that can be imported to MongoDB.
mars_info = {}

# NASA mars news
def scrape_mars_news():
    try:
        # Initialize the browser 
        browser = init_browser()

        # Visit Nasa news URL 
        url = 'https://mars.nasa.gov/news/'
        browser.visit(url)

        # HTML Object
        html = browser.html

        # Parse HTML with Beautiful Soup
        soup = BeautifulSoup(html, 'html.parser')

        # Retrive the latest elements that contain news title and paragraph text
        news_title = soup.find('div', class_='content_title').find('a').text
        news_p = soup.find('div', class_='article_teaser_body').text

        # Dictionary entry for mars news
        mars_info['news_title'] = news_title
        mars_info['news_paragraph'] = news_p

        return mars_info

    finally:
        browser.quit()

# Featured Image
def scrape_mars_image():
    try:
         # Initialize the browser 
        browser = init_browser()

        # Visit Nasa mars images URL
        image_url_featured = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
        browser.visit(image_url_featured)

        # HTML Object
        html_image = browser.html

        # Parse HTML with Beautiful soup
        soup = BeautifulSoup(html_image, 'html.parser')

        # Retrieve background image URL from the style tag
        background_image_url = soup.find('article')['style'].replace('background-image: url(','').replace(');', '')[1:-1]

        # Website URL 
        jpl_url = 'https://www.jpl.nasa.gov'

        # Join the URLs
        join_url = jpl_url + background_image_url

        # Display the full link
        join_url

        # Dictionary entry from the featured image
        mars_info['join_url'] = join_url

        return mars_info
    finally:
        browser.quit

# Mars Weather 
def scrape_mars_weather():
    try:
        # Initialize the browser 
        browser = init_browser()
        
        #Visit mars weather Twitter URL
        weather_url = 'https://twitter.com/marswxreport?lang=en'
        browser.visit(weather_url)

        # HTML Object 
        html_weather = browser.html

        # Parse HTML with Beautiful Soup
        soup = BeautifulSoup(html_weather, 'html.parser')

        # Find  all elements that contain tweets
        latest_tweets = soup.find_all('div', class_='js-tweet-text-container')

        # Retrieve elements that conrain the news title 
        # Look for entries that display weather related words
        for tweet in latest_tweets:
            weather_tweet = tweet.find('p').text
            if 'Sol' and 'pressure' in weather_tweet:
                print(weather_tweet)
                break
            else:
                pass

        # Dictionary entry from mars weather Twitter
        mars_info['weather_tweet'] = weather_tweet

        return mars_info
    finally:
        browser.quit()

# Mars Facts 
def scrape_mars_facts():

    # Visit mars facts URL
    facts_url = 'http://space-facts.com/mars/'

    # Use Panda's read_html to parse the URL
    mars_facts = pd.read_html(facts_url)

    # Find and assign mars facts to facts_df
    facts_df = mars_facts[0]

    # Assign the columns
    facts_df.columns = ['description', 'value']
   
    # Set the index to the Description column
    facts_df.set_index('description', inplace=True)

    # Save the html code
    data = facts_df.to_html()

    # Dictionaly entry from mars facts
    mars_info['mars_facts'] = data
    
    return mars_info

# Mars Hemispheres
def scrape_mars_hemispheres():
    
    try:
        # Initialize browser
        browser = init_browser()

        # Visit hemispheres webisite
        hemispheres_url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
        browser.visit(hemispheres_url)

        # HTML Object
        html_hemispheres = browser.html

        # Parse HTML with Beautiful Soup
        soup = BeautifulSoup(html_hemispheres, 'html.parser')

        #  Retreive all items that contain information related to mars hemispheres
        items  = hemispheres_soup.find_all('div', class_='item')

        # Create an empty list for hemispheres urls
        hemispheres_urls = []

        # store the main url
        main_url = 'https://astrogeology.usgs.gov'  

        # Loop 
        for i in items:
    
            title = i.find('h3').text
    
            partial_url = i.find('a', class_='itemLink product-item')['href']
    
            browser.visit(main_url + partial_url)
    
            partial_html = browser.html
    
            hemispheres_soup = BeautifulSoup(partial_html, 'html.parser')
    
            img_url = main_url + soup.find('img', class_='wide-image')['src']
    
            hemispheres_urls.append({"title": title, "img_url": img_url})

        mars_info['hemispheres_urls'] = hemispheres_urls

        # Return mars_data dictionary 
        return mars_info

    finally:
        browser.quit()




























