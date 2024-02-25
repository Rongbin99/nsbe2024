import io
import sqlite3
from flask import Flask, request, jsonify, send_file, g
import math
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

def haversine(lat1, lon1, lat2, lon2):
    # Convert latitude and longitude from degrees to radians
    lat1 = math.radians(lat1)
    lon1 = math.radians(lon1)
    lat2 = math.radians(lat2)
    lon2 = math.radians(lon2)

    # Difference in coordinates
    dlat = lat2 - lat1
    dlon = lon2 - lon1

    # Haversine formula
    a = math.sin(dlat / 2)**2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    # Radius of Earth in kilometers
    R = 6371.0

    # Calculate distance
    distance = R * c

    return distance

@app.route("/")
def home():
    return "Hello, World!"

def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect('data.db')
    return g.db

app.config["DATABASE"] = "./data.db"

@app.route('/users/<int:user_id>')
def user_profile(user_id):
    db = get_db()
    cur = db.cursor()
    cur.execute("SELECT * FROM Users WHERE UserID=?", (user_id,))
    user = cur.fetchone()
    if user is None:
        return jsonify({"error": "User not found"}), 404
    else:
        return jsonify({"UserID": user[0], "Name": user[1], "Score": user[2]})

@app.route('/login/<string:username>/<string:password>')
def login(username, password):
    db = get_db()
    cur = db.cursor()
    cur.execute("SELECT * FROM Users WHERE Name=?", (username,))
    user = cur.fetchone()
    print(user)
    
    if user is None or user[5] != password:
        return jsonify({"status": "fail"})
    else:
        return jsonify({"status": "success"})
    
@app.route('/leaderboard/<int:user_id>')
def get_leaderboard(user_id):
    db = get_db()
    cur = db.cursor()
    cur.execute("SELECT * FROM Users ORDER BY Score DESC")
    topusers = cur.fetchall()
    cur.execute("SELECT * FROM Users WHERE UserID=?", (user_id,))
    user = cur.fetchone()

    outlist = []

    for topuser in topusers:
        if topuser[0] != user_id and haversine(topuser[3], topuser[4], user[3], user[4]) <= 5:
            outlist.append(topuser)

    return jsonify(outlist)


@app.route("/feed")
def feed():
    db = get_db()
    cur = db.cursor()
    cur.execute("SELECT * FROM Posts")
    posts = cur.fetchall()
    return jsonify(posts)


    # conn = sqlite3.connect("data/app.db")
    # cur = conn.cursor()
    # cur.execute("SELECT * FROM posts;")
    # entries = cur.fetchall()
    # cur.close()

    # for entry in entries:
    #     entries[1] = entries[1].split(";")

    # return entries


@app.route("/upload")
def newpost():
    conn = sqlite3.connect("data/app.db")
    conn.execute(
        "INSERT INTO posts VALUES (?, ?);",
        (request.args.get("id"), request.args.get("image")),
    )
    conn.commit()

    return ":)"


@app.route("/images/upload")
def newimage():
    conn = sqlite3.connect("data/app.db")
    conn.execute(
        "INSERT INTO posts VALUES (?, ?);",
        (request.args.get("id"), request.args.get("data")),
    )
    conn.commit()

    return ":D"

@app.teardown_appcontext
def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()

if __name__ == "__main__":
    app.run(debug=True)
