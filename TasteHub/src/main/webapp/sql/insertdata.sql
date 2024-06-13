INSERT INTO User (userName, email, passwd, urlUserImg) VALUES (?, ?, ?, "img/Header/defaultIcon.png")

INSERT INTO Video(userID, title, detail, createDate, urlThumbnail, urlVideo, cntView, cntLike)
VALUES  (1, 'asdf', 'asdf', now(), '', '', 0, 0);

UPDATE User SET userName = ?, introTxt = ?, urlBackImg = ?, urlUserImg = ? WHERE userID = ?;

INSERT INTO Subscribe(userSubID, userID) VALUES (?, ?);

INSERT INTO View(userID, videoID, viewDate) VALUES (?, ?, now());

INSERT INTO LikeBtn(userID, videoID, likeDate) VALUES (?, ?, now());