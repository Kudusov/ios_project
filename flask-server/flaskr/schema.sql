DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS timecafe;
DROP TABLE IF EXISTS timecafe_image;
DROP TABLE IF EXISTS feature;
DROP TABLE IF EXISTS timecafe_feature;


CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);

CREATE TABLE post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE timecafe (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, 
    main_image_url TEXT,
    rating FLOAT NOT NULL DEFAULT 0,
    latitude FLOAT NOT NULL,
    longtitude FLOAT NOT NULL,
    address TEXT NOT NULL,
    station TEXT NOT NULL,
    price FLOAT,
    price_type INT,
    website TEXT DEFAULT "",
    phone_number TEXT DEFAULT "",
    working_time TEXT DEFAULT "",
    extended_price TEXT DEFAULT ""
);

CREATE TABLE timecafe_image (
  timecafe_id INTEGER,
  image_url TEXT,
  FOREIGN KEY(timecafe_id) REFERENCES timecafe(id)
);

CREATE TABLE feature (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE timecafe_feature (
  timecafe_id INTEGER,
  feature_id INTEGER,
  FOREIGN KEY(timecafe_id) REFERENCES timecafe(id),
  FOREIGN KEY(feature_id) REFERENCES feature(id)
);

INSERT INTO timecafe (name, main_image_url, latitude, longtitude, address, station, price, price_type, website, phone_number, working_time, extended_price) VALUES 
                     ("Local Time", "/static/img/local_time_0.jpg", 55.7728362, 37.6689673, "Новорязанская ул. 29с4", "Бауманская", 2.5, 1, "http://localtime.su", "+7 (965) 276-67-66", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Белый Лист", "/static/img/beliy_list_0.jpg", 55.7594813, 37.6383845, "Валовая ул., 32/75", "Добрынинская", 120, 0, "https://belylist.ru/", "8 (964) 566-33-35", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Убежище", "/static/img/ubejishe_0.jpg", 55.7612416, 37.6354802, "Архангельский пер., 7c1", "Чистые пруды", 2, 1, "timeclub24.ru", "8 (495) 215-57-14", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Wooden Door", "/static/img/wooden_door_0.jpg", 55.7620639, 37.6297389, "Милютинский пер., 6с1", "Лубянка", 160, 0, "wdndoor.com", "8 (495) 748-93-38", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("ComeIn", "/static/img/comein_0.jpg", 55.773665, 37.5812432, "ул. Грузинский Вал, 26с3", "Белорусская", 140, 0, "comein-kafe.ru", "8 (495) 104-35-39", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("CheckPoint", "/static/img/check_point_0.jpeg", 55.7635506, 37.6323984, "Мясницкая ул., 17c2", "Чистые пруды", 1.5, 1, "chpoint.ru", "8 (499) 955-45-09", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("12 ярдов", "/static/img/12yardov_0.jpg", 55.7296808, 37.5096452, "ул. Братьев Фонченко, 10к1", "Парк Победы", 200, 0, "12yards.ru", "8 (495) 737-80-63", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Happy People", "/static/img/happy_people_0.jpg", 55.74115, 37.6278034, "Климентовский пер. 6", "Новокузнецкая", 150, 0, "anticafe-hp.ru", "8 (495) 545-11-52", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Коперник", "/static/img/kopernik_0.jpg", 55.7412297, 37.5599525, "пр. Вернадского, 11/19,", "Университет", 150, 0, "8 (495) 374-99-54", "antikafe.com", "|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 22:00|9:00 - 01:00|9:00 - 01:00|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|");

 
INSERT INTO timecafe_image (timecafe_id, image_url) VALUES (1, "/static/img/local_time_1.jpg"),
                                                           (1, "/static/img/local_time_2.jpg"),
                                                           (1, "/static/img/local_time_3.jpg"),
                                                           (1, "/static/img/local_time_4.jpg"),
                                                           (1, "/static/img/local_time_5.jpg"),
                                                           (2, "/static/img/local_time_0.jpg"),
                                                           (2, "/static/img/local_time_1.jpg"),
                                                           (2, "/static/img/local_time_2.jpg"),
                                                           (2, "/static/img/local_time_3.jpg"),
                                                           (2, "/static/img/local_time_4.jpg"),
                                                           (2, "/static/img/local_time_5.jpg"),
                                                           (3, "/static/img/local_time_0.jpg"),
                                                           (3, "/static/img/local_time_1.jpg"),
                                                           (3, "/static/img/local_time_2.jpg"),
                                                           (3, "/static/img/local_time_3.jpg"),
                                                           (3, "/static/img/local_time_4.jpg"),
                                                           (3, "/static/img/local_time_5.jpg"),
                                                           (4, "/static/img/local_time_0.jpg"),
                                                           (4, "/static/img/local_time_1.jpg"),
                                                           (4, "/static/img/local_time_2.jpg"),
                                                           (4, "/static/img/local_time_3.jpg"),
                                                           (4, "/static/img/local_time_4.jpg"),
                                                           (4, "/static/img/local_time_5.jpg"),
                                                           (5, "/static/img/local_time_0.jpg"),
                                                           (5, "/static/img/local_time_1.jpg"),
                                                           (5, "/static/img/local_time_2.jpg"),
                                                           (5, "/static/img/local_time_3.jpg"),
                                                           (5, "/static/img/local_time_4.jpg"),
                                                           (5, "/static/img/local_time_5.jpg"),
                                                           (6, "/static/img/local_time_0.jpg"),
                                                           (6, "/static/img/local_time_1.jpg"),
                                                           (6, "/static/img/local_time_2.jpg"),
                                                           (6, "/static/img/local_time_3.jpg"),
                                                           (6, "/static/img/local_time_4.jpg"),
                                                           (6, "/static/img/local_time_5.jpg"),
                                                           (7, "/static/img/local_time_0.jpg"),
                                                           (7, "/static/img/local_time_1.jpg"),
                                                           (7, "/static/img/local_time_2.jpg"),
                                                           (7, "/static/img/local_time_3.jpg"),
                                                           (7, "/static/img/local_time_4.jpg"),
                                                           (7, "/static/img/local_time_5.jpg"),
                                                           (8, "/static/img/local_time_0.jpg"),
                                                           (8, "/static/img/local_time_1.jpg"),
                                                           (8, "/static/img/local_time_2.jpg"),
                                                           (8, "/static/img/local_time_3.jpg"),
                                                           (8, "/static/img/local_time_4.jpg"),
                                                           (8, "/static/img/local_time_5.jpg"),
                                                           (9, "/static/img/local_time_0.jpg"),
                                                           (9, "/static/img/local_time_1.jpg"),
                                                           (9, "/static/img/local_time_2.jpg"),
                                                           (9, "/static/img/local_time_3.jpg"),
                                                           (9, "/static/img/local_time_4.jpg"),
                                                           (9, "/static/img/local_time_5.jpg");


INSERT INTO feature(name) VALUES ("playstation"), ("rooms"), ("board_games"), ("ping_pong"), ("musical_instrument"), ("hookah");

-- INSERT INTO timecafe_feature(timecafe_id, feature_id) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6),
--                                                                 (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6),
--                                                                 (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6),
--                                                                 (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6),
--                                                                 (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6),
--                                                                 (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6),
--                                                                 (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6),
--                                                                 (8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6),
--                                                                 (9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6),
--                                                                 (10, 1), (10, 2), (10, 3), (10, 4), (10, 5), (10, 6);



INSERT INTO timecafe_feature(timecafe_id, feature_id) VALUES (1, 1), (1, 2), 
                                                                (2, 3), (2, 4),
                                                                (3, 1), (3, 2), (3, 3),
                                                                (4, 1), (4, 2), (4, 3), (4, 4),
                                                                (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6),
                                                                (6, 4), (6, 5), (6, 6),
                                                                (7, 5), (7, 6),
                                                                (8, 3), (8, 4),
                                                                (9, 4), (9, 5), (9, 6),
                                                                (10, 3), (10, 4);


