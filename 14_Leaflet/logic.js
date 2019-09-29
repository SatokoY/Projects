console.log("working");

// JSON URL Link
var json_link = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"

function markerSize(magnitude) {
    return magnitude * 30000;
}

function markerColor(magnitude) {
    if (magnitude <= 1) {
        return "#98ee00";
    } else if (magnitude <= 2) {
        return "#d4ee00";
    } else if (magnitude <= 3) {
        return "#eecc00";
    } else if (magnitude <= 4) {
        return "#ee9c00";
    } else if (magnitude <= 5) {
        return "#ea822c";
    } else {
        return "#ea2c2c";
    };
}

// Get request to the query URL
d3.json(json_link, function(data) {
    createFeatures(data.features);
  });

function createFeatures(earthquakeData) {
    var earthquakes = L.geoJSON(earthquakeData, {
       onEachFeature : function (feature, layer) {
          layer.bindPopup("<h3>" + feature.properties.place +
            "</h3><hr><p>" + new Date(feature.properties.time) + "</p>" + "<p> Magnitude: " +  feature.properties.mag + "</p>")
          },     pointToLayer: function (feature, latlng) {
            return new L.circle(latlng,
              {radius: markerSize(feature.properties.mag),
              fillColor: markerColor(feature.properties.mag),
              fillOpacity: 1,
              stroke: false,
          })
        }
});

// Layer earthquakes for the function createMap
    createMap(earthquakes);
}

function createMap(earthquakes) {
    // Define satellite map layer
    var map_satellite = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.satellite",
    accessToken: API_Key
  });

    // Define dark map layer
    var map_dark = L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
    attribution: "Map data; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
    maxZoom: 18,
    id: "mapbox.dark",
    accessToken: API_Key
  });

    // Define basemap
    var map_base = {
        "Satellite_Map": map_satellite,
        "Dark_Map": map_dark
    };

    // Create overlay object
    var map_overlay = {
        Earthquakes: earthquakes
    };

    // Create the map object
    var map = L.map("map", {
        center: [40.7, -94.5],
        zoom: 3,
        layers: [map_satellite, earthquakes]
      }); 

    // Create a layer control and add it to the map
    L.control.layers(map_base, map_overlay, {
        collapsed: false
      }).addTo(map);
    
      var legend = L.control({position: 'bottomright'});
    
      legend.onAdd = function () {
      
          var div = L.DomUtil.create('div', 'info legend'),
              magnitudes = [0, 1, 2, 3, 4, 5];
      
          for (var i = 0; i < magnitudes.length; i++) {
              div.innerHTML +=
                  '<i style="background:' + markerColor(magnitudes[i] + 1) + '"></i> ' + 
          + magnitudes[i] + (magnitudes[i + 1] ? ' - ' + magnitudes[i + 1] + '<br>' : ' + ');
          }
      
          return div;
      };
      
      legend.addTo(map);
}