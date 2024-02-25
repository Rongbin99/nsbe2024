import sqlite3

# delete and remake empty data.db
with open('data.db', 'w') as f:
    pass

# Connect to the SQLite database
conn = sqlite3.connect('data.db')

# Create a cursor object
c = conn.cursor()

# Create Users table
c.execute('''
    CREATE TABLE Users (
        UserID INTEGER PRIMARY KEY,
        Name TEXT NOT NULL,
        Score INTEGER,
        Latitude REAL,
        Longitude REAL
    )
''')

# Create UserPosts table
c.execute('''
    CREATE TABLE UserPosts (
        UserID INTEGER,
        PostID TEXT,
        FOREIGN KEY(UserID) REFERENCES Users(UserID)
    )
''')

# user on website
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (0, 'User1', 5, 43.66077989564984, -79.39651244065237))

# users within 5km
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (1, 'User2', 3, 43.65646578952676, -79.45241136895724))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (3, 'User4', 4, 43.66292275302812, -79.39648735564788))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (8, 'User5', 9283, 43.677897944323306, -79.38631594883611))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2348, 'User6', -1, 43.64318838064361, -79.3689840768619))

# users outside 5km
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (4, 'User7', 1, -3.3746612447567244, -40.78137606031826))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2, 'User3', 4, 43.81405921356005, -79.32505081401312))

# Commit the changes and close the connection
conn.commit()
conn.close()