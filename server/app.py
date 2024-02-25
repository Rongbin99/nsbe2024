import io
import sqlite3
from flask import Flask, request

app = Flask(__name__)


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
    
@app.route('/leaderboard')
def get_leaderboard():
    db = get_db()
    cur = db.cursor()
    cur.execute("SELECT * FROM Users ORDER BY Score DESC")
    users = cur.fetchall()
    return jsonify(users)


@app.route("/feed")
def feed():
    conn = sqlite3.connect("data/app.db")
    cur = conn.cursor()
    cur.execute("SELECT * FROM posts;")
    entries = cur.fetchall()
    cur.close()

    for entry in entries:
        entries[1] = entries[1].split(";")

    return entries


@app.route("/images/<thumb>")
def getimage(thumb):
    conn = sqlite3.connect("data/app.db")
    img = conn.execute("SELECT ? FROM thumbnails;", thumb)
    conn.close()

    return send_file(io.BytesIO(img), mimetype="image/jpeg")


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
