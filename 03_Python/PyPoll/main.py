import os
import csv

# Define a function to print and export it to a text file
# Memo: def functionName(parameters):
def printLineToScreenAndFile(line, fileWriter):
    print(line)
    fileWriter.write(line + "\n")

# export a text file with the results
# memo: Reading and Writing Files in Python
f = open("output.txt", "w")

# Path to collect data from the resources folder
ElectionCSV = os.path.join('Resources', 'election_data.csv')

# Display initial messages
printLineToScreenAndFile("Election Results", f)
printLineToScreenAndFile("-------------------------------", f)

with open(ElectionCSV, 'r') as csvfile:

    # Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    header = next(csvreader)

    # Loop through the data
    totalVotes = 0
    votesByCandidate = {}
   
    numRows = 0
    for row in csvreader:
        totalVotes += 1
        numRows += 1

        # Add a vote for each candidate. If the candidate
        # hasn't gotten a vote yet, they will be added to the list
        candidateName = row[2]
        if candidateName in votesByCandidate:
            votesByCandidate[candidateName] += 1
        else:
            votesByCandidate[candidateName] = 0

# The total number of votes cast
printLineToScreenAndFile(f"Total Votes: {str(totalVotes)}", f)
printLineToScreenAndFile("-------------------------------", f)

# A complete list of candidates who received votes
# The percentage of votes each candidate won
# The total number of votes each candidate won
for candidateName,candidateVotes in votesByCandidate.items():
    PercentageCandidate = (int(candidateVotes) / totalVotes) * 100
    PercentageCandidate = "{0:0.3f}".format(PercentageCandidate)
    printLineToScreenAndFile(f"{str(candidateName)} {str(PercentageCandidate)}% ({str(candidateVotes)})", f)

# The winner of the election based on popular vote.
mostVotes = 0
winnerName = ''
for candidateName,candidateVotes in votesByCandidate.items():
    if (candidateVotes > mostVotes):
        mostVotes = candidateVotes
        winnerName = candidateName

printLineToScreenAndFile("-------------------------------", f)
printLineToScreenAndFile(f"Winner: {str(winnerName)}", f)
printLineToScreenAndFile("-------------------------------", f)
