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
        Longitude REAL,
        Password TEXT NOT NULL
    )
''')

# Create Posts table
c.execute('''
    CREATE TABLE Posts (
        UserID INTEGER,
        PostID INTEGER PRIMARY KEY,
        ImagePath TEXT,
        Latitude REAL,
        Longitude REAL,
        FOREIGN KEY(UserID) REFERENCES Users(UserID)
    )
''')

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2, 1, "loot.jpg", 43.677969618181194, -79.4084936933702))
c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (1, 2, "rong2.jpg", 43.677969618181194, -79.4084936933702))

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (0, 3, "evan4.jpg", 43.82616304654565, -79.30611972838412))
c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2, 4, "loot4.jpg", 43.82616304654565, -79.30611972838412))

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (0, 5, "evan3.jpg", 43.64864905481929, -79.37137374188521))
c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2, 6, "loot3.jpg", 43.64864905481929, -79.37137374188521))

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (0, 7, "evan1.jpg", 43.84219936951136, -79.54119404557709))
c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (2, 8, "loot2.jpg", 43.84219936951136, -79.54119404557709))

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (1, 9, "rong3.jpg", 43.66943871876222, -79.33943955298747))

c.execute("INSERT INTO Posts (UserID, PostID, ImagePath, Latitude, Longitude) VALUES (?, ?, ?, ?, ?)", 
          (3, 10, "jim.png", 43.768547556924595, -79.52192865500804))


# user on website
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude, Password) VALUES (?, ?, ?, ?, ?, ?)", 
          (0, 'Evan', 15, 43.66077989564984, -79.39651244065237, "mosaicevan"))

# users within 5km
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude, Password) VALUES (?, ?, ?, ?, ?, ?)", 
          (1, 'Rongbin', 10, 43.65646578952676, -79.45241136895724, "mosaicrongbin"))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude, Password) VALUES (?, ?, ?, ?, ?, ?)", 
          (2, 'Luthira', 15, 43.66292275302812, -79.39648735564788, "mosaicluthira"))
c.execute("INSERT INTO Users (UserID, Name, Score, Latitude, Longitude, Password) VALUES (?, ?, ?, ?, ?, ?)", 
          (3, 'Zain', 5, 43.677897944323306, -79.38631594883611, "mosaiczain"))

# Commit the changes and close the connection
conn.commit()
conn.close()