//
//  AuthManager.swift
//  Project2
//
//  Created by qwerty on 5/24/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum AuthError {
    case success
    case emailConflict
    case userNotFound
    case incorrectCredentials
    case someError
}

class MyAuthManager {
    func signup(email: String, fullname: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        guard let url = URL(string: baseUrl + "/api/registration") else {
            completionBlock(false)
            return
        }

        Alamofire.request(url, method: .post, parameters: ["email": email, "username": fullname, "password": password], encoding: JSONEncoding.default).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(false)
                return;
            }

            if let json = try? JSON(data: dataResponse.data!) {
                print("accessToken" + json["access_token"].stringValue)
                print("refreshToken" + json["refresh_token"].stringValue)
            }
            print("statusCode")
            print(dataResponse.response?.statusCode ?? 400)

        }
    }

    func signup2(email: String, fullname: String, password: String, completionBlock: @escaping (_ success: AuthError) -> Void) {
        guard let url = URL(string: baseUrl + "/api/registration") else {
            completionBlock(.someError)
            return
        }

        Alamofire.request(url, method: .post, parameters: ["email": email, "username": fullname, "password": password], encoding: JSONEncoding.default).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(.someError)
                return;
            }

            if resp.statusCode == 201 {
                if let json = try? JSON(data: dataResponse.data!) {
                    print("accessToken" + json["access_token"].stringValue)
                    print("refreshToken" + json["refresh_token"].stringValue)
                    AuthBearer.save(json["access_token"].stringValue, json["refresh_token"].stringValue)
                    completionBlock(.success)
                }
            } else if resp.statusCode == 409 {
                completionBlock(.emailConflict)
            }
        }
    }

    func login(email: String, password: String, completionBlock: @escaping (_ success: AuthError) -> Void) {
        guard let url = URL(string: baseUrl + "/api/login") else {
            completionBlock(.someError)
            return
        }

        Alamofire.request(url, method: .post, parameters: ["email": email, "password": password], encoding: JSONEncoding.default).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(.someError)
                return;
            }

            if resp.statusCode == 200 {
                if let json = try? JSON(data: dataResponse.data!) {
                    print("accessToken" + json["access_token"].stringValue)
                    print("refreshToken" + json["refresh_token"].stringValue)
                    AuthBearer.save(json["access_token"].stringValue, json["refresh_token"].stringValue)
                    completionBlock(.success)
                }
            } else if resp.statusCode == 401 {
                completionBlock(.incorrectCredentials)
            }
        }
    }

    func refreshToken(completionBlock: @escaping (_ success: AuthError) -> Void) {
        guard let url = URL(string: baseUrl + "/api/refresh") else {
            completionBlock(.someError)
            return
        }
        let credentials = AuthBearer.getCredentials()
        if (credentials.refreshToken == "") {
            completionBlock(.someError)
            return
        }
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + credentials.refreshToken]).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(.someError)
                return;
            }

            if resp.statusCode == 200 {
                if let json = try? JSON(data: dataResponse.data!) {
                    print("accessToken" + json["access_token"].stringValue)
//                    print("refreshToken" + json["refresh_token"].stringValue)
                    AuthBearer.save(json["access_token"].stringValue, credentials.refreshToken)
                    completionBlock(.success)
                }
            } else if resp.statusCode == 401 {
                completionBlock(.incorrectCredentials)
            }
        }
    }
}


class UserInfoManager {

    
    func isUserAuthorized(completionBlock: @escaping (_ success: Bool) -> Void) {
        guard let url = URL(string: baseUrl + "/api/me") else {
            completionBlock(false)
            return
        }
        let credentials = AuthBearer.getCredentials()
        if (credentials.refreshToken == "") {
            completionBlock(false)
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer" + "token"]).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(false)
                return;
            }

            if resp.statusCode == 200 {
                if let json = try? JSON(data: dataResponse.data!) {
                    print("accessToken" + json["access_token"].stringValue)
                    print("refreshToken" + json["refresh_token"].stringValue)
                    AuthBearer.save(json["access_token"].stringValue, json["refresh_token"].stringValue)
                    completionBlock(true)
                }
            } else if resp.statusCode == 401 {
                completionBlock(false)
            }
        }
    }

    private func getUserInfoWithoutTokenUpdating(completionBlock: @escaping (_ success: AuthError, _ user: User) -> Void) {
        guard let url = URL(string: baseUrl + "/api/me") else {
            completionBlock(.someError, User(username: "", email: ""))
            return
        }
        let credentials = AuthBearer.getCredentials()
        if (credentials.accessToken == "" || credentials.refreshToken == "") {
            completionBlock(.someError, User(username: "", email: ""))
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer " + credentials.accessToken]).response { (dataResponse) in
            guard let resp = dataResponse.response else {
                completionBlock(.someError, User(username: "", email: ""))
                return;
            }

            if resp.statusCode == 200 {
                if let json = try? JSON(data: dataResponse.data!) {
                    let user = User(username: json["username"].stringValue, email: json["email"].stringValue)
                    completionBlock(.success, user)
                }
            } else if resp.statusCode == 401 {
                completionBlock(.incorrectCredentials, User(username: "", email: ""))
            }
        }
    }

    func getUserInfo(completionBlock: @escaping (_ success: AuthError, _ user: User) -> Void) {
        getUserInfoWithoutTokenUpdating() { (error, user) in
            if (error == .success || error == .someError) {
                print("error 1 == succes || error == .someError")
                print(error)
                completionBlock(error, user)
                return
            }

            let authManager = MyAuthManager()
            authManager.refreshToken() { (error) in

                if (error == .someError || error == .incorrectCredentials) {
                    print("error == .someError || error == .incorrectCredentials")
                    print(error)
                    completionBlock(error, User(username: "", email: ""))
                    return
                }

                self.getUserInfoWithoutTokenUpdating() { (error, user) in
                    completionBlock(error, user)
                }
            }
        }
    }
}
