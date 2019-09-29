// @TODO: YOUR CODE HERE!
// Store width and height parameters for canvas
var svg_width = 900;
var svg_height = 600;

// Set margins
var margin = {
    top: 40,  
    right: 40,
    bottom: 80,
    left: 90
};

// Create width and height based on margins and parameters to fit within the canvas
var width = svg_width - margin.left - margin.right;
var height = svg_height - margin.top - margin.bottom;

// Create the canvas to add the svg group to contain the states data
var svg = d3.select("#scatter")
    .append("svg")
    .attr("width", svg_width)
    .attr("height", svg_height);

// Create the chart group to contain the data
var chart_group = svg.append("g")
    .attr("transform", `translate(${margin.left}, ${margin.top})`);

// Import the data
var data_file = "assets/data/data.csv"

d3.csv(data_file).then(successHandle).catch(errorHandle);

function errorHandle(error) {
    throw error;
}

function successHandle(statesData) {
    // console.log(statesData);

    // Loop through the data pass argument 
    statesData.map(function (data) {
        data.poverty = +data.poverty;
        data.obesity = +data.obesity;
    });

    // Create scale functions
    var xLinearScale = d3.scaleLinear()
    .domain([8.1, d3.max(statesData, d => d.poverty)])
    .range([0, width]);

    var yLinearScale = d3.scaleLinear()
    .domain([20, d3.max(statesData, d => d.obesity)])
    .range([height, 0]);

    // Create axis functions
    var bottomAxis = d3.axisBottom(xLinearScale)
    .ticks(7);
    var leftAxis = d3.axisLeft(yLinearScale);

    // Append the axes to the chart grouup
    chart_group.append("g")
    .attr("transform", `translate(0, ${height})`)
    .call(bottomAxis);

    chart_group.append("g")
    .call(leftAxis);

    // Create circles for the scatter plot
    var circle_group = chart_group.selectAll()
        .data(statesData)
        .enter()
        .append("circle")
        .attr("cx", d => xLinearScale(d.poverty))
        .attr("cy", d => yLinearScale(d.obesity))
        .attr("r", "13")
        .attr("fill", "#788dc2")
        .attr("opacity", ".75")

    // Add texts to circles
    var  circle_group = chart_group.selectAll()
        .data(statesData)
        .enter()
        .append("text")
        .attr("x", d => xLinearScale(d.poverty))
        .attr("y", d => yLinearScale(d.obesity))
        .style("font-size", "13px")
        .style("text-anchor", "middle")
        .style('fill', 'white')
        .text(d => (d.abbr));

    // Initialize toolTip
    var toolTip = d3.tip()
        .attr("class", "tooltip")
        .offset([80, -60])
        .html(function (d) {
        return (`${d.state}<br>Poverty: ${d.poverty}%<br>Obesity: ${d.obesity}% `);
        });

    // Create tooTip in the chart
    chart_group.call(toolTip);

    // Create mouseover to show and hide the toolTip
    circle_group.on("mouseover", function (data) {
        toolTip.show(data, this);
      })
        // onmouseout event
        .on("mouseout", function (data) {
          toolTip.hide(data);
        });

    // Create axes labels
    chart_group.append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 0 - margin.left + 40)
        .attr("x", 0 - (height / 2))
        .attr("dy", "1em")
        .attr("class", "axisText")
        .text("Obesity (%)");

    chart_group.append("text")
        .attr("transform", `translate(${width / 2}, ${height + margin.top + 30})`)
        .attr("class", "axisText")
        .text("Poverty (%)");


}

