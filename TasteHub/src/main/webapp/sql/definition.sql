/*init table*/
/*User*/
Create table User (
    userID INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(30),
    passwd VARCHAR(30),
    userName VARCHAR(10),
    urlUserImg VARCHAR(500),
    urlBackImg VARCHAR(500),
    introTxt TEXT,
    cntSub LONG,
    PRIMARY KEY(userID)
    );

/*Video*/
CREATE TABLE Video (
    videoID INT NOT NULL AUTO_INCREMENT,
    userID INT,
    title VARCHAR(500),
    detail VARCHAR(500),
    createDate DATE,
    urlThumbnail VARCHAR(500),
    urlVideo VARCHAR(500),
    cntView LONG,
    cntLike LONG,
    PRIMARY KEY(videoID),
    FOREIGN KEY (userID) REFERENCES User(userID)
    );
CREATE FULLTEXT INDEX Video_Index ON Video(title) WITH PARSER ngram;

/*Subscribe*/
CREATE table Subscribe(
    subID INT NOT NULL AUTO_INCREMENT,
    userSubID INT,
    userID INT,
    PRIMARY KEY(subID),
    FOREIGN KEY (userSubID) REFERENCES User(userID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);

/*Commenet*/
CREATE table Comment(
    commitID INTEGER NOT NULL AUTO_INCREMENT,
    userID INT,
    videoID INT,
    comments VARCHAR(500),
    PRIMARY KEY(commitID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (videoID) REFERENCES Video(videoID)
);

/*LikeBtn*/
CREATE TABLE LikeBtn (
    likeID INT NOT NULL AUTO_INCREMENT,
    userID INT,
    videoID INT,
    likeDate datetime(6),
    PRIMARY KEY(likeID),
    FOREIGN KEY(userID) references User(userID),
    FOREIGN KEY(videoID) references Video(videoID)
);

/*View*/
CREATE TABLE View(
    viewID INT NOT NULL AUTO_INCREMENT,
    userID INT,
    videoID INT,
    viewDate datetime,
    PRIMARY KEY(viewID),
    FOREIGN KEY(userID) references User(userID),
    FOREIGN KEY(videoID) references Video(videoID)
);