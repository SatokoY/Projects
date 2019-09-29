// from data.js
var tableData = data;

// Get table references 
var tbody = d3.select("tbody");

function buildTable(data) {
    // Clear any existing data
    tbody.html("");

    // Loop through each object in the data
    // and append a row and cells for each values in the row
    data.forEach((dataRow) => {
        var row = tbody.append("tr");

        // Loop through each field in the dataRow and 
        // add value as a table cell (td)
        Object.values(dataRow).forEach((val) => {
            var cell = row.append("td");
            cell.text(val);
        });
    });
}

// Keep track of all filters 
var filters = {};

function updateFilters() {
    // Save the element, value and id of the filter that was changed
    var changedElement = d3.select(this).select("input");
    var elementValue = changedElement.property("value");
    var filterID = changedElement.attr("id");

    // If a filter value was entered then add the filterId and value to the filters list
    // Otherwise, clear the filter from the filters object
    if (elementValue) {
        filters[filterID] = elementValue;
    }
    else {
        delete filters[filterID];
    }
    // Call function to apply all filters and rebuild the table
    filterTable();
}

function filterTable() {
    // Set the filteredData to the tableData
    let filteredData = tableData;

    // Loop through all of the filters and keep any data
    // that matches the filter values 
    Object.entries(filters).forEach(([key, value]) => {
        filteredData = filteredData.filter(row => row[key] === value);
    });

    // Finally, rebuild the table using the filteredData
    buildTable(filteredData);
}


// Attach an event to listhen for the form button
d3.selectAll(".filter").on("change", updateFilters);

// Build the table when the page loads
buildTable(tableData);
