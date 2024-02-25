import sqlite3

# Connect to the SQLite database
conn = sqlite3.connect('data.db')

# Create a cursor object
c = conn.cursor()

# Create Users table
c.execute('''
    CREATE TABLE Users (
        UserID INTEGER PRIMARY KEY,
        Name TEXT NOT NULL,
        Score INTEGER
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

c.execute("INSERT INTO Users (UserID, Name, Score) VALUES (?, ?, ?)", (0, 'User1', 5))
c.execute("INSERT INTO Users (UserID, Name, Score) VALUES (?, ?, ?)", (1, 'User2', 3))

# Commit the changes and close the connection
conn.commit()
conn.close()