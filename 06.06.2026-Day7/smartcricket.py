import csv
import numpy as np
import pandas as pd
from collections import defaultdict

players = []

def read_players_file(filename):
    try:
        with open(filename, mode='r') as file:
            reader = csv.DictReader(file)

            for row in reader:
                try:
                    row['matches'] = int(row['matches'])
                    row['runs'] = int(row['runs'])
                    row['fours'] = int(row['fours'])
                    row['sixes'] = int(row['sixes'])
                except ValueError:
                    print("Invalid numeric value")
                    continue

                players.append(row)

        print("CSV File Loaded Successfully")

    except FileNotFoundError:
        print("players.csv file not found")

read_players_file("players.csv")

def display_all_records():
    for player in players:
        print(player)

def count_total_players():
    return len(players)

def highest_run_scorer():
    top_player = max(players, key=lambda x: x['runs'])
    return top_player['player_name'], top_player['runs']

def lowest_run_scorer():
    low_player = min(players, key=lambda x: x['runs'])
    return low_player['player_name'], low_player['runs']

def calculate_average_runs():
    total_runs = sum(player['runs'] for player in players)
    return total_runs / len(players)

def players_above_600():
    for player in players:
        if player['runs'] > 600:
            print(player['player_name'], player['runs'])

def players_below_500():
    for player in players:
        if player['runs'] < 500:
            print(player['player_name'], player['runs'])

def count_players_by_team():
    team_count = defaultdict(int)

    for player in players:
        team_count[player['team']] += 1

    return dict(team_count)

def total_runs_by_team():
    team_runs = defaultdict(int)

    for player in players:
        team_runs[player['team']] += player['runs']

    return dict(team_runs)

def find_best_team():
    team_runs = total_runs_by_team()
    top_team = max(team_runs, key=team_runs.get)

    return top_team, team_runs[top_team]

def find_lowest_team():
    team_runs = total_runs_by_team()
    low_team = min(team_runs, key=team_runs.get)

    return low_team, team_runs[low_team]

def player_most_fours():
    player = max(players, key=lambda x: x['fours'])
    return player['player_name'], player['fours']

def player_most_sixes():
    player = max(players, key=lambda x: x['sixes'])
    return player['player_name'], player['sixes']

def total_fours():
    return sum(player['fours'] for player in players)

def total_sixes():
    return sum(player['sixes'] for player in players)

def player_names_list():
    names = [player['player_name'] for player in players]
    names.sort()
    return names

def unique_teams():
    return {player['team'] for player in players}

def team_runs_dictionary():
    return total_runs_by_team()

def player_runs_dictionary():
    player_runs = {}

    for player in players:
        player_runs[player['player_name']] = player['runs']

    return player_runs

def find_top_scorer():
    return highest_run_scorer()

def find_total_boundaries():
    return total_fours() + total_sixes()

def numpy_analysis():
    runs_array = np.array([player['runs'] for player in players])

    print("Total Runs:", np.sum(runs_array))
    print("Average Runs:", np.mean(runs_array))
    print("Maximum Runs:", np.max(runs_array))
    print("Minimum Runs:", np.min(runs_array))
    print("Standard Deviation:", np.std(runs_array))
    print("Median:", np.median(runs_array))

def pandas_analysis():
    try:
        df = pd.read_csv("players.csv")

        print("\nTop 5 Run Scorers")
        print(df.sort_values(by='runs', ascending=False).head())

        print("\nPlayers Sorted By Runs")
        print(df.sort_values(by='runs', ascending=False))

        print("\nTeam Wise Total Runs")
        print(df.groupby('team')['runs'].sum())

        print("\nTeam Wise Average Runs")
        print(df.groupby('team')['runs'].mean())

        print("\nPlayers With Runs > 600")
        print(df[df['runs'] > 600])

        top_team = df.groupby('team')['runs'].sum().idxmax()
        print("\nTop Team:", top_team)

    except FileNotFoundError:
        print("players.csv file not found")

def generate_report():
    with open("cricket_report.txt", "w") as file:

        file.write(f"Total Players: {count_total_players()}\n")

        total_runs = sum(player['runs'] for player in players)
        file.write(f"Total Runs: {total_runs}\n")

        file.write(f"Average Runs: {calculate_average_runs()}\n")

        top_player, top_runs = highest_run_scorer()
        file.write(f"Highest Scorer: {top_player} ({top_runs})\n")

        low_player, low_runs = lowest_run_scorer()
        file.write(f"Lowest Scorer: {low_player} ({low_runs})\n")

        file.write("\nTeam Wise Runs:\n")

        for team, runs in total_runs_by_team().items():
            file.write(f"{team}: {runs}\n")

        file.write("\nTop 5 Players:\n")

        sorted_players = sorted(players, key=lambda x: x['runs'], reverse=True)

        for player in sorted_players[:5]:
            file.write(f"{player['player_name']} - {player['runs']}\n")

        most_fours_player, fours = player_most_fours()
        file.write(f"\nMost Fours: {most_fours_player} ({fours})\n")

        most_sixes_player, sixes = player_most_sixes()
        file.write(f"Most Sixes: {most_sixes_player} ({sixes})\n")

    print("cricket_report.txt generated successfully")

def generate_top_players_csv():
    try:
        df = pd.read_csv("players.csv")

        top_players = df[df['runs'] > 600]

        top_players.to_csv("top_players.csv", index=False)

        print("top_players.csv generated")

    except FileNotFoundError:
        print("players.csv file not found")

def generate_team_summary():
    try:
        df = pd.read_csv("players.csv")

        summary = df.groupby('team').agg(
            Total_Runs=('runs', 'sum'),
            Average_Runs=('runs', 'mean'),
            Player_Count=('player_id', 'count')
        )

        summary.to_csv("team_summary.csv")

        print("team_summary.csv generated")

    except FileNotFoundError:
        print("players.csv file not found")

def player_analysis_menu():
    print("Highest Run Scorer:", highest_run_scorer())
    print("Lowest Run Scorer:", lowest_run_scorer())
    print("Average Runs:", calculate_average_runs())

def team_analysis_menu():
    print(total_runs_by_team())
    print("Best Team:", find_best_team())
    print("Lowest Team:", find_lowest_team())

def boundary_analysis_menu():
    print("Most Fours:", player_most_fours())
    print("Most Sixes:", player_most_sixes())
    print("Total Fours:", total_fours())
    print("Total Sixes:", total_sixes())

def export_reports():
    generate_report()
    generate_top_players_csv()
    generate_team_summary()

def main():
    while True:

        print("\nSMART CRICKET ANALYTICS SYSTEM")
        print("1. Player Analysis")
        print("2. Team Analysis")
        print("3. Boundary Analysis")
        print("4. Export Reports")
        print("5. Pandas Analysis")
        print("6. NumPy Analysis")
        print("7. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            player_analysis_menu()

        elif choice == '2':
            team_analysis_menu()

        elif choice == '3':
            boundary_analysis_menu()

        elif choice == '4':
            export_reports()

        elif choice == '5':
            pandas_analysis()

        elif choice == '6':
            numpy_analysis()

        elif choice == '7':
            print("Program Ended")
            break

        else:
            print("Invalid Choice")

main()
