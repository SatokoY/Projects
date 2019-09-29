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
function handleClick() {
    // Prevent the form from refreshing the page
    d3.event.preventDefault();

    // Grab the datetime value from the filter
    var date = d3.select("#datetime").property("value");
    let filteredData = tableData;

    // Check to see if a date was entered and 
    // filter the data using the date
    if(date) {
        // Apply `filter` to the table data to only keep the rows
        // where the `datetime` value matches the filter value
        filteredData = filteredData.filter(row => row.datetime === date);
    }

    // Rebuild the tables using filtered data
    // If no date was entered, then filterData will just be the original tableData
    buildTable(filteredData);
}

// Attach an event to listhen for the form button
d3.selectAll("#filter-btn").on("click", handleClick);

// Build the table when the page loads
buildTable(tableData);
