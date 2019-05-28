DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS timecafe;
DROP TABLE IF EXISTS timecafe_image;
DROP TABLE IF EXISTS feature;
DROP TABLE IF EXISTS timecafe_feature;
DROP TABLE IF EXISTS mark;


CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE NOT NULL,
  username TEXT NOT NULL,
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
    lower_name TEXT NOT NULL,
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
  description TEXT DEFAULT "", 
  FOREIGN KEY(timecafe_id) REFERENCES timecafe(id),
  FOREIGN KEY(feature_id) REFERENCES feature(id)
);

CREATE TABLE mark (
  user_id INTEGER NOT NULL,
  timecafe_id INTEGER NOT NULL,
  rating FLOAT DEFAULT 0,
  review TEXT DEFAULT 0,
  UNIQUE(user_id, timecafe_id),
  FOREIGN KEY(user_id) REFERENCES user(id),
  FOREIGN KEY(timecafe_id) REFERENCES timecafe(id)
);


INSERT INTO timecafe (name, lower_name, main_image_url, latitude, longtitude, address, station, price, price_type, website, phone_number, working_time, extended_price) VALUES 
                     ("Local Time", "local time", "/static/img/local_time_0.jpg", 55.7728362, 37.6689673, "Новорязанская ул. 29с4", "Бауманская", 130, 1, "http://localtime.su", "+7 (965) 276-67-66", "|9:00 - 22:00|(пн-пт)|9:00 - 01:00|(сб-вс)|", "|1-ый час|130₽|Со 2-го часа|1.75 ₽/мин|Ночной стопчек|500₽|Дневной стопчек|от 500₽|"),
                     ("Белый Лист", "белый лист", "/static/img/beliy_list_0.jpg", 55.7594813, 37.6383845, "Валовая ул., 32/75", "Добрынинская", 3, 1, "https://belylist.ru/", "8 (964) 566-33-35", "|9:00 - 22:00|(пн-пт)|9:00 - 01:00|(сб-вс)|", "|Базовый тариф| |Цена|3 ₽/мин|Стопчек|700р|Чайный тариф| |Цена|3.5 ₽/мин|Стопчек|800₽|Кофейный тариф| |Цена|4 ₽/мин|Стопчек|900₽|"),
                     ("Убежище", "убежище", "/static/img/ubejishe_0.jpg", 55.7612416, 37.6354802, "Архангельский пер., 7c1", "Чистые пруды", 2.49, 1, "timeclub24.ru", "8 (495) 215-57-14", "|Круглосуточно|Ежедневно|", "|С клубной картой| |06:00 - 09:59|0.99 ₽/мин|10:00 - 16:59|2.49 ₽/мин|17:00 - 20:59|2.99 ₽/мин|21:00 - 05:59|2.49 ₽/мин|Гостевой тариф| |Цена|2.99 ₽/мин|"),
                     ("Wooden Door", "wooden door", "/static/img/wooden_door_0.jpg", 55.7620639, 37.6297389, "Милютинский пер., 6с1", "Лубянка", 2, 1, "wdndoor.com", "8 (495) 748-93-38", "|12:00 - 00:00|(пн-чт,вс)|9:00 - 01:00|(пт-сб)|", "|Первые 2 часа|2 ₽/мин|Далее|1 ₽/мин|Ночной стопчек|400₽|"),
                     ("ComeIn", "comein", "/static/img/comein_0.jpg", 55.773665, 37.5812432, "ул. Грузинский Вал, 26с3", "Белорусская", 1.99, 1, "comein-kafe.ru", "8 (495) 104-35-39", "|11:00 - 07:00|Ежедневно|", "|С клубной картой| |11:00 – 13:00|1.99 ₽/мин|13:00 – 07:00|2.77 ₽/мин|Студентам с клубной картой| |Цена|3.33 ₽/мин|Гостевой тариф| |Цена|3.33 ₽/мин|"),
                     ("CheckPoint", "checkpoint", "/static/img/check_point_0.jpeg", 55.7635506, 37.6323984, "Мясницкая ул., 17c2", "Чистые пруды", 170, 0, "chpoint.ru", "8 (499) 955-45-09", "|Круглосуточно|Ежедневно|", "|Цена|170₽|Со 2-го часа|2 ₽/мин|"),
                     ("12 ярдов", "12 ярдов", "/static/img/12yardov_0.jpg", 55.7296808, 37.5096452, "ул. Братьев Фонченко, 10к1", "Парк Победы", 120, 0, "12yards.ru", "8 (495) 737-80-63", "|12:00 - 23:00|Ежедневно|", "|1-ый час|120₽|Со 2-го часа|2 ₽/мин|Стопчек|500₽|"),
                     ("Happy People", "happy people", "/static/img/happy_people_0.jpg", 55.74115, 37.6278034, "Климентовский пер. 6", "Новокузнецкая", 150, 0, "anticafe-hp.ru", "8 (495) 545-11-52", "|9:00 - 22:00|(пн-пт)|9:00 - 01:00|(сб-вс)|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|"),
                     ("Коперник", "коперник", "/static/img/kopernik_0.jpg", 55.7412297, 37.5599525, "пр. Вернадского, 11/19,", "Университет", 150, 0, "8 (495) 374-99-54", "antikafe.com", "|9:00 - 22:00|(пн-пт)|9:00 - 01:00|(сб-вс)|", "|1-ый час|250р|Со 2-го часа|2р/мин|Стопчек|500р|");

 
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


INSERT INTO feature(name) VALUES ("playstation"), ("rooms"), ("board_games"), ("ping_pong"), ("musical_instrument"), ("hookah"), ("wifi"), ("tea_and_coffee"), ("projector"), ("eat");

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



INSERT INTO timecafe_feature(timecafe_id, feature_id, description) VALUES 
                                                                (1, 1, "2 приставки  PS4"), (1, 2, "Можете забронировать маленькую комнату"), (1, 3, "Более 185 настольных игр"), (1, 4, "Настольный теннис на нашей веранде"), (1, 5, "Караоке, гитара, пианино"), (1, 7, "Бесплатный wifi"), (1, 8, "Чай, кофе, печеньки"), (1, 9, "Проектор для проведения мероприятий"),
                                                                (2, 3, "Коллекция настольных игр"),(2, 2, "Около десяти комнат разного размера, есть отдельные комнаты на 2-4-6-10-20-40 человек. Комнаты можно бесплатно бронировать."), (2, 7, "Бесплатный wifi"), (2, 8, "Чай, кофе, печеньки"), (2, 5, "Гитара, укелеле"), (2, 9, "Проектор для проведения мероприятий"),
                                                                (3, 3, "Коллекция настольных игр"), (3,2, "Общий зал, игровая, кинозал, lounge"), (3, 7, "Бесплатный wifi"), (3, 8, "Чай, кофе, печеньки"), (3, 5, "Гитара, фортепиано, синтезатор"), (3, 9, "Проектор для фильмов"),
                                                                (4, 1, "Xbox"), (4, 3, "Коллекция настольных игр"), (4, 6, "Дымные кальяны"), (4, 7, "Бесплатный wifi"), (4, 8, "Чай, кофе, печеньки, горячий шоколад"), (4, 9, "Пицца, суши, бургеры"),
                                                                (5, 1, "3 PS4, XBox One"), (5, 3, "Коллекция настольных игр"), (5, 7, "Бесплатный wifi"), (5, 8, "Чай, кофе, печеньки"),  (5, 9, "Проектор для фильмов"),
                                                                (6, 1, "Xbox, PlayStation, SEGA"), (6, 2, "Более 20 залов"), (6, 3, "Коллекция настольных игр"), (6, 7, "Бесплатный wifi"), (6, 8, "Чай, кофе, печеньки"), (6, 9, "Проекторы для презентаций и просмотра фильмов"), (6, 5, "Караоке, музыкальные инструменты"),
                                                                (7, 1, "Xbox, PS4, PS3"), (7, 2, "Несколько отдельных комнат"), (7, 3, "Коллекция настольных игр"), (7, 7, "Бесплатный wifi"), (7, 8, "Чай, кофе, печеньки"), (7, 4, "Настольный теннис"), (7, 5, "Караоке, гитара"),
                                                                (8, 1, "Xbox, PlayStation"), (8, 3, "Коллекция настольных игр"), (8, 7, "Бесплатный wifi"), (8, 8, "Чай, кофе, печеньки"),
                                                                (9, 3, "Коллекция настольных игр"), (9, 7, "Бесплатный wifi"), (9, 8, "Чай, кофе, печеньки");
                                                                -- (10, 3, "Коллекция настольных игр"), (10, 7, "Бесплатный wifi"), (10, 8, "Чай, кофе, печеньки");



