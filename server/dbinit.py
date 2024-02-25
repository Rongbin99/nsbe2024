import sqlite3

conn = sqlite3.connect("data/app.db")
conn.execute("CREATE TABLE posts (id TEXT PRIMARY KEY NOT NULL, images TEXT NOT NULL);")
conn.execute("CREATE TABLE images (id TEXT PRIMARY KEY NOT NULL, image BLOB NOT NULL);")
conn.close()
