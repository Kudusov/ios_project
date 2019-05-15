# -*- coding: utf-8 -*-
import os

import json
from flask import Flask, jsonify, make_response, request, abort, Response, send_from_directory, redirect, helpers
from flask.views import MethodView
from . import db

class TimeCafe:
    def __init__(self, id, name, main_image_url, rating, latitude, longtitude, address, station, price):
        self.id = id
        self.name = name
        self.main_image_url = main_image_url
        self.rating = rating
        self.latitude = latitude
        self.longtitude = longtitude
        self.address = address
        self.station = station
        self.price = price

    def to_json(self):
	    return { 'id': self.id, 'name': self.name, 'main_image_url': self.main_image_url, 
                  'rating': self.rating, 'latitude': self.latitude, 'longtitude': self.longtitude, 
                   'address': self.address, 'station': self.station, 'price': self.price }

class TimeCafeAPI(MethodView):
    def get(self, cafe_id):
        db_con = db.get_db()
        if cafe_id is None:
            # res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address, \
            #                       t.station, t.price, t.price_type, t.website, t.phone_number, t.working_time, t.extended_price, group_concat(f.name) as features \
            #                        from timecafe t join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id group by t.id")
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features \
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id     \
                                  group by t.id")         
            items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
            for item in items:
                features_str = item["features"]
                features = list(set(features_str.split(',')))
                item["features"] = [{"feature" : feature} for feature in features]

                images_str = item["images"]
                images = list(set(images_str.split(',')))
                item["images"] = [{"image": image} for image in images]

            resp = make_response(jsonify(items))

            resp.status_code = 200
            return resp
        else:
            print('hello')
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features \
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id     \
                                  where t.id = ? group by t.id", (cafe_id,))
            res_line = res.fetchone()
            res_dict = dict(zip([key[0] for key in res.description], [r for r in res_line]))
            images_str = res_dict["images"]
            images = list(set(images_str.split(',')))

            res_dict["images"] = [{"image": image} for image in images]

            features_str = res_dict["features"]
            features = list(set(features_str.split(',')))
            res_dict["features"] = [{"feature" : feature} for feature in features]
            resp = make_response(jsonify(res_dict))
            resp.status_code = 200
            return resp
        db_con.close()

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True, static_url_path='/static')
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        app.config.from_pyfile('config.py', silent=True)
    else:
        app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    db.init_app(app)
    @app.route('/hello')
    def hello():
        return "Hello world"
    
    @app.route('/img/<path:path>')
    def send_img(path):
        print(os.path.abspath(os.path.dirname(__file__)))
        return app.send_static_file('img/' + path)

    cafe_view = TimeCafeAPI.as_view('user_api')
    app.add_url_rule('/api/cafes/', defaults={'cafe_id': None}, view_func=cafe_view, methods=['GET'])
    app.add_url_rule('/api/cafes/<int:cafe_id>', view_func=cafe_view, methods=['GET'])

    return app