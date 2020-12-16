from flask import Flask, render_template, request, redirect, jsonify, make_response
from flask_mysqldb import MySQL
import yaml

app = Flask(__name__)

# Configure MySQL DB

db = yaml.load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

mysql = MySQL(app)


@app.route('/')
def index():
    return 'Leeds United Fan API'


@app.route('/players')
def players():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT PlayerName FROM LUFC_Players")
    if resultValue > 0:
        playerDetails = cur.fetchall()
        return render_template('players.html', playerDetails=playerDetails)


@app.route('/teams')
def teams():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT TeamName, Stadium FROM OppositionDetails WHERE League = 'PremierLeague'")
    if resultValue > 0:
        teamDetails = cur.fetchall()
        return render_template('teams.html', teamDetails=teamDetails)

@app.route('/mostbeaten')
def mostbeaten():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT Opponent, COUNT(Result) as 'Win Count' FROM (SELECT * FROM LUFC_FixturesResults WHERE Result = 'W') sub1 GROUP BY Opponent ORDER BY COUNT(Result) DESC Limit 5;")
    if resultValue > 0:
        to_json = cur.fetchall()
        json_return = jsonify(to_json)
        return json_return

@app.route('/leedsgoals')
def leedsgoals():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT Player, Distance, BodyPart FROM GameShots WHERE Outcome = 'Goal' AND Squad = 'Leeds United';")
    if resultValue > 0:
        to_json = cur.fetchall()
        json_return = jsonify(to_json)
        return json_return


@app.route('/player/<int:number>/')
def player(number):
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT PlayerID, PlayerName, Positions, TotalMinutesPlayed FROM SportStatsDB.LUFC_Players HAVING PlayerID = %s;" % number)
    if resultValue > 0:
        to_json = cur.fetchall()
        json_return = jsonify(to_json)
        return json_return


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)


if __name__ == '__main__':
    app.run(debug=True)