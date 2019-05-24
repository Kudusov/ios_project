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

class TimeCafeAPI(MethodView):
    def get(self, cafe_id):
        db_con = db.get_db()
        search_text = request.args.get("search")
        if cafe_id is None and search_text is None:
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
        
        elif cafe_id is None and search_text:
            res = db_con.execute("Select t.id, t.name, t.main_image_url, t.rating, t.latitude, t.longtitude, t.address,  \
                                  t.station, t.price, t.price_type, t.website, t.phone_number, group_concat(ti.image_url) as images, t.working_time, t.extended_price, group_concat(f.name) as features \
                                  from timecafe t join timecafe_image ti on t.id = ti.timecafe_id \
                                  join timecafe_feature tf on t.id = tf.timecafe_id join feature f on tf.feature_id = f.id  where t.lower_name LIKE ?   \
                                  group by t.id", ('%' + search_text.lower() + '%',))         
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


class UserModel:
    def __init__(self, username, email, password):
        self.username = username
        self.email = email
        self.password = password

    def save_to_db(self):
        try:
            db_con = db.get_db()
            db_con.execute("Insert into user (username, email, password) Values(?, ?, ?)", (self.username, self.email, self.password,))
            db_con.commit()
        finally:
            if db_con:
                db_con.close()

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
        resp = make_response(jsonify(current_user))
        resp.status_code = 200
        return resp
'''
class UserModel(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String(120), unique = True, nullable = False)
    password = db.Column(db.String(120), nullable = False)
    
    def save_to_db(self):
        db.session.add(self)
        db.session.commit()
    
    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username = username).first()
    
    @classmethod
    def return_all(cls):
        def to_json(x):
            return {
                'username': x.username,
                'password': x.password
            }
        return {'users': list(map(lambda x: to_json(x), UserModel.query.all()))}

    @classmethod
    def delete_all(cls):
        try:
            num_rows_deleted = db.session.query(cls).delete()
            db.session.commit()
            return {'message': '{} row(s) deleted'.format(num_rows_deleted)}
        except:
            return {'message': 'Something went wrong'}

    @staticmethod
    def generate_hash(password):
        return sha256.hash(password)
    
    @staticmethod
    def verify_hash(password, hash):
        return sha256.verify(password, hash)

class RevokedTokenModel(db.Model):
    __tablename__ = 'revoked_tokens'
    id = db.Column(db.Integer, primary_key = True)
    jti = db.Column(db.String(120))
    
    def add(self):
        db.session.add(self)
        db.session.commit()
    
    @classmethod
    def is_jti_blacklisted(cls, jti):
        query = cls.query.filter_by(jti = jti).first()
        return bool(query)
'''

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
    # api.add_resourse(TimeCafeAPI, '/api/cafes')
    app.add_url_rule('/api/cafes/', defaults={'cafe_id': None}, view_func=cafe_view, methods=['GET'])
    app.add_url_rule('/api/cafes/<int:cafe_id>', view_func=cafe_view, methods=['GET'])
    app.add_url_rule('/api/registration', view_func = reg_view, methods = ['POST'])
    app.add_url_rule('/api/login', view_func = log_view, methods = ['POST'])
    app.add_url_rule('/api/refresh', view_func = token_refresh_view, methods = ['POST'])
    app.add_url_rule('/api/me', view_func = user_view, methods = ['GET'])

    
    return app
