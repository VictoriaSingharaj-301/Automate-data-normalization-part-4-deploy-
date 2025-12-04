#!/bin/bash
# Victoria Singharaj
# Information Systems Automation - Part 3
#This script normalizes NFL game data into CSV format
# Output CSV header
echo "Date, Time, Away_Team, Home_Team"
# Read input file (first command-line argument)
INPUT_FILE="$1"
#Clean up the data -remove empty lines and headers
cat "$INPUT_FILE" | \
	grep -v '^$' | \
	grep -v 'NFL Scoreboard' | \
	grep -v 'Gamecast' | \
	grep -v 'Odds provided' | \
	grep -v 'ESPN Bet' | \
	grep -v 'Tickets as low'
# Initialize variables to store game data
date=""
time=""
away_team=""
home_team=""
#Process each line
cat "$INPUT_FILE" | \
	grep -v '^$' | \
	grep -v 'NFL Scoreboard' |\
	grep -v 'Gamecast' | \
	grep -v 'Odds provided' | \
	grep -v 'ESPN Bet' | \
	grep -v 'Tickets as low' | \
while IFS= read -r line; do

	# Detect date lines
	if [[ "$line" =~ ^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday) ]]; then
        date="$line"
	fi
	# Detect time lines
	if  [[ "$line" =~ ^[0-9]+:[0-9]+ ]]; then 
	time="$line"
	fi
done

	#Detect team names
	if [[ "$line" =~ ^(Bills|Texans|Steelers|Bears|Patriots|Bengals|Giants|Lions|Vikings|Packers|Seahawks|Titans|Colts|Chiefs|Jets|Ravens|Browns|Raiders|Jaguars|Cardinals|Eagles|Cowboys|Falcons|Saints|Buccaneers|Rams|Panthers|49ers)$ ]]; then 
if [[ -z "$away_team" ]]; then
away_team="$line"
else
home_team="$line"
# Output the CSV line when we have all 4 pieces of data
echo "$date,$time,$away_team,$home_team"
# Reset for next game 
away_team=""
home_team=""
fi
fi
