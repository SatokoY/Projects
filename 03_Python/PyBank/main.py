import os
import csv

# Path to collect data from the resources folder
BudgetCSV = os.path.join('Resources', 'budget_data.csv')

# Display initial messages
print("Financial Analysis")
print("-------------------------------")


with open(BudgetCSV, 'r') as csvfile:

    # Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    header = next(csvreader)

    # Loop through the data
    numMonths = 0
    totalProfit = 0
    maxProfitIncrease = 0
    previousMonthProfitLoss = 0
    maxProfitDecrease = 0
    totalChanges = 0

    for row in csvreader:
        numMonths = numMonths + 1
        totalProfit = totalProfit + int(row[1])

        # Start checking for differences after second data row.
        if numMonths > 1:
            monthDifference = int(row[1]) - int(previousMonthProfitLoss)
            totalChanges = totalChanges + monthDifference

            if monthDifference > maxProfitIncrease:
              maxProftIncreaseMonthName = row[0]
              maxProfitIncrease = monthDifference

            if monthDifference < maxProfitDecrease:
              maxProfitDecreaseMonthName = row[0]
              maxProfitDecrease = monthDifference

        # Start remembering the previous row profit/loss only after using it.
        previousMonthProfitLoss = row[1]
    
# The total number of months included in the dataset
print(f"Total Months: {str(numMonths)}")

# The net total amount of "Profit/Losses" over the entire period 
# Same result as a below line->  print("Total profit: ", totalProfit) 
print(f"Total profit: ${str(totalProfit)}")

# The average of the changes in "Profit/Losses" over the entire period
AverageChanges = totalChanges / (numMonths - 1) 
AverageChanges = round(AverageChanges, 2)
print(f"Average Change: ${str(AverageChanges)}")

# The greatest increase in profits (date and amount) over the entire period
# Same result as a below line->  print("Greatest Increase in Profits:", maxProftIncreaseMonthName, maxProfitIncrease)
print(f"Greatest Increase in Profits: {str(maxProftIncreaseMonthName)} (${str(maxProfitIncrease)})")

# The greatest decrease in losses (date and amount) over the entire period
## print(f"Greatest Decreas
print(f"Greatest Decrease in Profits: {str(maxProfitDecreaseMonthName)} (${str(maxProfitDecrease)})")

# export a text file with the results
f = open("output.txt", "w")
f.write("Financial Analysis\n") 
f.write("-------------------------------\n") 
f.write(f"Total Months: {str(numMonths)}\n") # \n means new line(Unix)
f.write(f"Total profit: ${str(totalProfit)}\n")
f.write(f"Average Change: ${str(AverageChanges)}\n")
f.write(f"Greatest Increase in Profits: {str(maxProftIncreaseMonthName)} (${str(maxProfitIncrease)})\n")
f.write(f"Greatest Decrease in Profits: {str(maxProfitDecreaseMonthName)} (${str(maxProfitDecrease)})\n")
