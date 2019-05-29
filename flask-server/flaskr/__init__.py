# -*- coding: utf-8 -*-
import os

import json
from flask import Flask, jsonify, make_response, request, abort, Response, send_from_directory, redirect, helpers
from flask.views import MethodView
from passlib.hash import pbkdf2_sha256 as sha256
from flask_restful import Api
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flask_restful import Resource, reqparse
from flask_jwt_extended import (create_access_token, create_refresh_token, jwt_required, jwt_refresh_token_required, get_jwt_identity, get_raw_jwt)
import requests
import random
from faker import Faker


from . import db

parser = reqparse.RequestParser()
parser.add_argument('email', help = 'This field cannot be blank', required = True)
parser.add_argument('username', help = 'This field cannot be blank', required = False)
parser.add_argument('password', help = 'This field cannot be blank', required = True)

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

class Feature:
    def __init__(self, feature, description):
        self.feature = feature
        self.description = description
    
    def __eq__(self, other):
        return self.feature == other.feature and self.description == other.description

class TimeCafeAPI(MethodView):
    def get(self, cafe_id):
        db_con = db.get_db()
        search_text = request.args.get("search")
        if cafe_id is None and search_text is None:
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features, group_concat(tf.description, '|') as description\
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id     \
                                  group by t.id")         
            items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
            for item in items:
                features_str = item["features"]
                features = features_str.split(',')

                description_str = item["description"]
                descriptions = description_str.split('|')

                feat_desr = []
                for i in range(len(features)):
                    feat = Feature(feature=features[i], description=descriptions[i])
                    if feat not in feat_desr:
                        feat_desr.append(feat)
                
                # if len(features) > len(descriptions):
                #     features = features[:len(descriptions)]
                # elif len(descriptions) > len(features):
                #     descriptions = descriptions[:len(features)]

                item["features"] = [{"feature" : feat_desr[i].feature, "description": feat_desr[i].description} for i, _ in enumerate(feat_desr)]

                images_str = item["images"]
                images = list(set(images_str.split(',')))
                item["images"] = [{"image": image} for image in images]

            resp = make_response(jsonify(items))

            resp.status_code = 200
            return resp
        
        elif cafe_id is None and search_text:
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features, group_concat(tf.description, '|') as description\
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id   where t.lower_name LIKE ?   \
                                  group by t.id", ('%' + search_text.lower() + '%',))         
            items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
            for item in items:
                features_str = item["features"]
                features = features_str.split(',')

                description_str = item["description"]
                descriptions = description_str.split('|')

                feat_desr = []
                for i in range(len(features)):
                    feat = Feature(feature=features[i], description=descriptions[i])
                    if feat not in feat_desr:
                        feat_desr.append(feat)
                
                # if len(features) > len(descriptions):
                #     features = features[:len(descriptions)]
                # elif len(descriptions) > len(features):
                #     descriptions = descriptions[:len(features)]

                item["features"] = [{"feature" : feat_desr[i].feature, "description": feat_desr[i].description} for i, _ in enumerate(feat_desr)]

                images_str = item["images"]
                images = list(set(images_str.split(',')))
                item["images"] = [{"image": image} for image in images]

            resp = make_response(jsonify(items))

            resp.status_code = 200
            return resp

        else:
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features, group_concat(tf.description, '|') as description\
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id     \
                                  where t.id = ? group by t.id", (cafe_id,))
            res_line = res.fetchone()
            item = dict(zip([key[0] for key in res.description], [r for r in res_line]))
            features_str = item["features"]
            features = features_str.split(',')

            description_str = item["description"]
            descriptions = description_str.split('|')

            feat_desr = []
            for i in range(len(features)):
                feat = Feature(feature=features[i], description=descriptions[i])
                if feat not in feat_desr:
                    feat_desr.append(feat)
            
            # if len(features) > len(descriptions):
            #     features = features[:len(descriptions)]
            # elif len(descriptions) > len(features):
            #     descriptions = descriptions[:len(features)]

            item["features"] = [{"feature" : feat_desr[i].feature, "description": feat_desr[i].description} for i, _ in enumerate(feat_desr)]

            images_str = item["images"]
            images = list(set(images_str.split(',')))
            item["images"] = [{"image": image} for image in images]
            resp = make_response(jsonify(item))
            resp.status_code = 200
            return resp
        db_con.close()

class RatingUser(MethodView):
    @jwt_required
    def get(self, cafe_id):
        db_con = db.get_db()
        useremail = get_jwt_identity()
        user = UserModel.find_by_email(useremail)
        res = db_con.execute("select * from mark where user_id = ? and timecafe_id = ?", (user['id'], cafe_id,))
        items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
        for item in items:
            item['username'] = "username"
        resp = make_response(jsonify(items))
        resp.status_code = 200
        return resp

    
class RatingApi(MethodView):
    @jwt_required
    def put(self):
        # insert or replace into mark (user_id, timecafe_id, rating, review) values(1, 1, 3, "some updating review")
        db_con = db.get_db()
        params = request.get_json()
        cafe_id = params['cafe_id']
        rating = params['rating']
        review = params['review'] or ''
        useremail = get_jwt_identity()
        db_con.execute("insert or replace into mark (user_id, timecafe_id, rating, review) values((Select id from user where email = ?), ?, ?, ?)", (useremail, cafe_id, rating, review, ))
        db_con.execute("update timecafe set rating = (select sum(rating)/count(rating) as rating from mark where timecafe_id = ? group by timecafe_id) where id = ?", (cafe_id, cafe_id, ))
        db_con.commit()
        print('cafe_id = ', cafe_id)
        print("Posted data : {}".format(request.get_json()))
        resp = make_response(jsonify({
            'message': "all_ok"
            }))
        resp.status_code = 200
        return resp

    def bin2text(self, s): 
        return "".join([chr(int(s[i:i+8],2)) for i in range(0,len(s),8)])

    def post(self):
        faker = Faker('ru')
        users = []
        for _ in range(10):
            users.append(UserModel(username=faker.name(), email=faker.email(), password=faker.password()))
        # res = requests.get("https://randomuser.me/api/?results=100&nat=us")
        # users = res.json()["results"]
        db_con = db.get_db()
        for user in users:
            user.save_to_db()
            
            # db_con.execute("insert or replace into mark (user_id, timecafe_id, rating, review) values((Select id from user where email = ?), ?, ?, ?)", (useremail, cafe_id, rating, review, ))
            # db_con.execute("update timecafe set rating = (select sum(rating)/count(rating) as rating from mark where timecafe_id = ? group by timecafe_id) where id = ?", (cafe_id, cafe_id, ))
        res = db_con.execute("select id from timecafe")
        items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
        for cafe in items:
            for user in users:
                rating = (random.uniform(3, 5))
                db_con.execute("insert or replace into mark (user_id, timecafe_id, rating, review) values((Select id from user where email = ?), ?, ?, ?)", (user.email, cafe["id"], rating, faker.text(), ))
            db_con.execute("update timecafe set rating = (select sum(rating)/count(rating) as rating from mark where timecafe_id = ? group by timecafe_id) where id = ?", (cafe["id"], cafe["id"], ))
        db_con.commit()
        resp = make_response(jsonify({
            'message': "all_ok"
            }))
        resp.status_code = 200
        return resp

    def get(self, cafe_id):
        db_con = db.get_db()
        user_id = request.args.get("user_id")
        if user_id is None:
            res = db_con.execute("select u.username, m.rating, m.review from user u join mark m on u.id = m.user_id where m.timecafe_id = ? and m.review <> \"\"", (cafe_id,))
            items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
            resp = make_response(jsonify(items))
            resp.status_code = 200
            return resp
        elif user_id:
            res = db_con.execute("select * from mark where user_id = ? and timecafe_id = ?", (user_id, cafe_id,))
            items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
            resp = make_response(jsonify(items))
            resp.status_code = 200
            return resp

class UserModel:
    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password = password

    def save_to_db(self):
        # try:
        db_con = db.get_db()
        db_con.execute("Insert into user (username, email, password) Values(?, ?, ?)", (self.username, self.email, self.password,))
        db_con.commit()
        # finally:
        #     if db_con:
        #         db_con.close()

    @staticmethod
    def find_by_email_without_pass(email):
        db_con = db.get_db()
        res = db_con.execute("Select username, email from user where email = ?", (email,))
        items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
        # db_con.close()
        if len(items) == 0:
            print("alo")
            return None
        else:
            return items[0]
        
    
    @staticmethod
    def find_by_email(email):
        db_con = db.get_db()
        res = db_con.execute("Select * from user where email = ?", (email,))
        items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
        # db_con.close()
        if len(items) == 0:
            return None
        else:
            return items[0]


    @staticmethod
    def generate_hash(password):
        return sha256.hash(password)
    
    @staticmethod
    def verify_hash(password, hash):
        return sha256.verify(password, hash)


        
class UserRegistration(MethodView):
    def post(self):
        data = parser.parse_args()
        
        if UserModel.find_by_email(data['email']):
            resp = make_response(jsonify({'message': 'User {} already exists'.format(data['email'])}))
            resp.status_code = 409
            return resp


        new_user = UserModel(
            email = data['email'],
            username = data['username'],
            password = UserModel.generate_hash(data['password'])
        )

        
        new_user.save_to_db()
        access_token = create_access_token(identity = data['email'])
        refresh_token = create_refresh_token(identity = data['email'])
        resp = make_response(jsonify({
            'message': 'User {} was created'.format(data['email']),
            'access_token': access_token,
            'refresh_token': refresh_token
            }))
        resp.status_code = 201
        return resp
        # except:
        #     resp = make_response(jsonify({'message': 'Something went wrong'}))
        #     resp.status_code = 500
        #     return resp


class UserLogin(MethodView):
    def post(self):
        print(request)
        data = parser.parse_args()
        current_user = UserModel.find_by_email(data['email'])
        
        if not current_user:
            resp = make_response({'message': 'User {} doesn\'t exist'.format(data['email'])})
            resp.status_code = 401
            return resp

        if UserModel.verify_hash(data['password'], current_user['password']):
            access_token = create_access_token(identity = data['email'])
            refresh_token = create_refresh_token(identity = data['email'])
            resp = make_response(jsonify({
                'message': 'Logged in as {}'.format(current_user['email']),
                'access_token': access_token,
                'refresh_token': refresh_token
                }))
            resp.status_code = 200
            return resp
        else:
            resp = make_response(jsonify({'message': 'Wrong credentials'}))
            resp.status_code = 401
            return resp


class UserLogoutAccess(MethodView):
    def post(self):
        return {'message': 'User logout'}


class UserLogoutRefresh(MethodView):
    def post(self):
        return {'message': 'User logout'}


class TokenRefresh(MethodView):
    @jwt_refresh_token_required
    def post(self):
        current_user = get_jwt_identity()
        access_token = create_access_token(identity = current_user)
        resp = make_response(jsonify({'access_token': access_token}))
        resp.status_code = 200
        return resp


class AllUsers(MethodView):
    def get(self):
        return UserModel.return_all()
    
    def delete(self):
        return UserModel.delete_all()


class SecretResource(MethodView):
    @jwt_required
    def get(self):
        return {
            'answer': 42
        }

class UserInfo(MethodView):
    @jwt_required
    def get(self):
        user_email = get_jwt_identity()
        current_user = UserModel.find_by_email_without_pass(user_email)
        if current_user is None:
            resp = make_response(jsonify({"message" : "Unauthorized"}))
            resp.status_code = 401
            return resp
        resp = make_response(jsonify(current_user))
        resp.status_code = 200
        return resp

# def get_cafes():
#     db_con = db.get_db()
#     res = db_con.execute("select id from timecefe")
#     items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
#     return items

def add_users():
    res = requests.get("https://randomuser.me/api/?results=100&nat=us")
    users = res.json()["results"]
    db_con = db.get_db()
    for user in users:
        u = UserModel(username=user["name"]["first"].capitalize() + " " +  user["name"]["last"].capitalize(),
                        email= user["email"], password=user["login"]["password"])
        u.save_to_db()
        db_con = db.get_db()
        # db_con.execute("insert or replace into mark (user_id, timecafe_id, rating, review) values((Select id from user where email = ?), ?, ?, ?)", (useremail, cafe_id, rating, review, ))
        # db_con.execute("update timecafe set rating = (select sum(rating)/count(rating) as rating from mark where timecafe_id = ? group by timecafe_id) where id = ?", (cafe_id, cafe_id, ))
        res = db_con.execute("select id from timecefe")
        items = [dict(zip([key[0] for key in res.description], [r for r in row])) for row in res]
        for cafe in items:
            for user in users:
                sentences_list = get_sentences(1)
                rating = (random.uniform(1, 5))
                db_con.execute("insert or replace into mark (user_id, timecafe_id, rating, review) values((Select id from user where email = ?), ?, ?, ?)", (user.email, cafe["id"], rating, sentences_list[0], ))
            db_con.execute("update timecafe set rating = (select sum(rating)/count(rating) as rating from mark where timecafe_id = ? group by timecafe_id) where id = ?", (cafe["id"], cafe["id"], ))
        db_con.commit()
        # print(u.username)
        

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
    app.config['JWT_SECRET_KEY'] = 'jwt-secret-string'
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = 60 * 60 * 24
    jwt = JWTManager(app)
    if test_config is None:
        app.config.from_pyfile('config.py', silent=True)
    else:
        app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    db.init_app(app)
    # add_users()
    @app.route('/hello')
    def hello():
        return "Hello world"
    
    @app.route('/img/<path:path>')
    def send_img(path):
        print(os.path.abspath(os.path.dirname(__file__)))
        return app.send_static_file('img/' + path)

    cafe_view = TimeCafeAPI.as_view('user_api')
    reg_view = UserRegistration.as_view('reg_api') 
    log_view = UserLogin.as_view('log_api')
    token_refresh_view = TokenRefresh.as_view('tok_api')
    user_view = UserInfo.as_view('user_info_api')
    rating_view = RatingApi.as_view('rating_api')
    rating_user_view = RatingUser.as_view('rating_user_api')
    # api.add_resourse(TimeCafeAPI, '/api/cafes')
    app.add_url_rule('/api/cafes/', defaults={'cafe_id': None}, view_func=cafe_view, methods=['GET'])
    app.add_url_rule('/api/cafes/<int:cafe_id>', view_func=cafe_view, methods=['GET'])
    app.add_url_rule('/api/registration', view_func = reg_view, methods = ['POST'])
    app.add_url_rule('/api/login', view_func = log_view, methods = ['POST'])
    app.add_url_rule('/api/refresh', view_func = token_refresh_view, methods = ['POST'])
    app.add_url_rule('/api/me', view_func = user_view, methods = ['GET'])
    app.add_url_rule('/api/me/marks/<int:cafe_id>', view_func = rating_user_view, methods = ['GET'])
    app.add_url_rule('/api/marks/', view_func = rating_view, methods = ['PUT'])
    app.add_url_rule('/api/marks/', view_func = rating_view, methods = ['POST'])
    app.add_url_rule('/api/marks/<int:cafe_id>', view_func = rating_view, methods = ['GET'])

    
    return app
