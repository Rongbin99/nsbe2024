import io
import sqlite3
from flask import Flask, request

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello, World!"


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


if __name__ == "__main__":
    app.run(debug=True)
