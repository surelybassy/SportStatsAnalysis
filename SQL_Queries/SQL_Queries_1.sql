# After importing the CSV created in Python We will now check the data is in correctly.

SELECT * FROM SportStatsDB.GameShots;
SELECT * FROM SportStatsDB.HistoricPremierLeaugeStats;
SELECT * FROM SportStatsDB.LUFC_FixturesResults;
SELECT * FROM SportStatsDB.LUFC_MatchStatistics2020;
SELECT * FROM SportStatsDB.LUFC_Players;
SELECT * FROM SportStatsDB.OppositionDetails;

# All data looks to have been inputed correctly.
# Set the primary keys.

ALTER TABLE `GameShots`
MODIFY COLUMN `EventID` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE `HistoricPremierLeaugeStats`
MODIFY COLUMN `id` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE `LUFC_FixturesResults`
MODIFY COLUMN `MatchID` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE `LUFC_Players`
MODIFY COLUMN `PlayerID` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;
ALTER TABLE `OppositionDetails`
MODIFY COLUMN `TeamID` INT(10) UNSIGNED PRIMARY KEY AUTO_INCREMENT;

# Set foreign keys.
ALTER TABLE LUFC_MatchStatistics2020 ADD FOREIGN KEY (`MatchID`) REFERENCES GameShots(`MatchID`);
ALTER TABLE GameShots ADD FOREIGN KEY (`Player`) REFERENCES LUFC_Players(`PlayerName`);

# Queries

# Players, ShotCount, Nationality and Goals
SELECT sub1.Player, sub1.ShotCount, p.Goals, RIGHT(p.Nationality, 3) as Nationality from LUFC_Players p
JOIN
(SELECT Player, COUNT(Player) as ShotCount FROM GameShots
WHERE Squad = 'Leeds United'
GROUP BY Player
ORDER BY ShotCount DESC) sub1 ON p.PlayerName = sub1.Player;

# Goals scored by Leeds Player
SELECT * FROM GameShots
WHERE Outcome = 'Goal' AND Squad = 'Leeds United';

# Conceded Goals
SELECT * FROM GameShots
WHERE Outcome = 'Goal' AND Squad != 'Leeds United';

# Conceded Goals from Set Player
SELECT COUNT(*) as 'Goals from Setplays' FROM
(SELECT * FROM GameShots
WHERE Outcome = 'Goal' AND Squad != 'Leeds United') sub1
WHERE Event1 = 'Pass (Dead)' OR Notes = 'Free Kick';


# Biggest capacity stadiums
SELECT Stadium, Capacity, TeamName as Club FROM OppositionDetails
ORDER BY Capacity DESC
LIMIT 5;

# Historic Leeds Results
SELECT Season, COUNT(Result) as 'Number of Wins' FROM LUFC_FixturesResults
WHERE Result = 'W'
GROUP BY Season;

# Highest Number of Spectators
SELECT Date, Opponent, Competition, Stadium, Attendance, Capacity, ROUND((Attendance/Capacity)*100 ,2) as Capacity FROM LUFC_FixturesResults f
JOIN OppositionDetails o on f.Opponent = o.TeamName 
ORDER BY Attendance DESC
LIMIT 1;

#Team we have beaten most often
SELECT Opponent, COUNT(Result) as 'Win Count' FROM
(SELECT * FROM LUFC_FixturesResults
WHERE Result = 'W') sub1
GROUP BY Opponent
ORDER BY COUNT(Result) DESC
Limit 5;


# Views
#Top Scorer this season
CREATE or REPLACE VIEW top_scorers as
SELECT Player, COUNT(Player) as 'Number of Goals' FROM
(SELECT * FROM GameShots
WHERE Outcome = 'Goal' AND Squad = 'Leeds United') sub1
GROUP BY Player
ORDER BY Count(Player) DESC;

SELECT * FROM top_scorers;

#Top Assist Player
CREATE or REPLACE VIEW assists as
SELECT AssistPlayer1 as Player, COUNT(AssistPlayer1) as 'Number of Assists' FROM
(SELECT * FROM GameShots
WHERE Outcome = 'Goal' AND Squad = 'Leeds United' AND AssistPlayer1 <> '') sub1
GROUP BY AssistPlayer1
ORDER BY Count(AssistPlayer1) DESC;

SELECT * FROM assists;

# Fun Stuff
SELECT BodyPart, COUNT(BodyPart) as Count FROM GameShots
GROUP BY BodyPart;

SELECT BodyPart, COUNT(BodyPart) as Count FROM GameShots
WHERE Outcome = "Goal" AND Squad = "Leeds United"
GROUP BY BodyPart;

SELECT BodyPart, COUNT(BodyPart) as Count FROM GameShots
WHERE Outcome = "Goal" AND Squad <> "Leeds United"
GROUP BY BodyPart;