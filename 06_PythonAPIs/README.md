# Data Analysis - WeatherPy

## Background 
Python script to visualize the weather of 500+ cities across the world of varying distance from the equator. To accomplish this, I will utilize a simple Python library, the OpenWeatherMap API, and a little common sense to create a representative model of weather across world cities.<br>
<br>
The visualization has a series of scatter plots to showcase the following relationships:<br>
  * Temperature (F) vs. Latitude
  * Humidity (%) vs. Latitude
  * Cloudiness (%) vs. Latitude
  * Wind Speed (mph) vs. Latitude<br>
<br>

The scripts acocomplishes the following:
  * Randomly select at least 500 unique (non-repeat) cities based on latitude and longitude.
  * Perform a weather check on each of the cities using a series of successive API calls.
  * Include a print log of each city as it's being processed with the city number and city name.
  * Save both a CSV of all data retrieved and png images for each scatter plot.<br>

## Three observable trends based on the data
  * Not surprisingly, temperate increases as you get closer to the equator. However, the temperate peaks at around 20 degrees latitude and not at the equator.
  * Cloudiness and humdity don't show strong correltions to latitude. However, it looks like humidity decreases the most at 2 separate troughs, 20 degrees latitude and -20 degrees.
  * Wind speed appears to increase slightly the further away you go from the equator. For a definitive conclusion, I would need to make another variable to analyze it.<br>
  <br>
  ![Latitude_MaxTemp](output_images/Latitude_vs_MaxTemperature.png)<br>
  ![Latitude_Humidity](output_images/Latitude_vs_Humidity.png)<br>
  ![Latitude_Cloudiness](output_images/Latitude_vs_Cloudiness.png)<br>
  ![Latitude_WindSpeed](output_images/Latitude_vs_WindSpeed.png)<br>

<!--
![PythonAPIs_1](Link later)<br>
![PythonAPIs_2](Link later)<br>
![PythonAPIs_3](Link later)<br>
![PythonAPIs_4](Link later)<br>
![PythonAPIs_5](Link later)<br>
![PythonAPIs_6](Link later)<br>
![PythonAPIs_7](Link later)<br>
![PythonAPIs_8](Link later)<br>
-->