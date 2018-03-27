//
//  AuthService.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY )
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY ) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL ) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    //post
    func registerUser(email : String , password : String ,completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email": lowerCaseEmail,
            "password": password,
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default).responseString { (response) in
            if response.result.error == nil {
                print("----------------------- : >")
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    //response
    func loginUser(email : String , password : String , completion : @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email":lowerCaseEmail,
            "password":password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                //using swifty json
                guard let data = response.data else { return }
                let json = try! JSON(data:data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                
                 print("----------------------- : > login success ")
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name : String , email : String , avatarName : String , avatarColor : String , completion : @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = [
            "name":name,
            "email":lowerCaseEmail,
            "avatarName":avatarName,
            "avatarColor":avatarColor,
        ]
        
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type" :"application/json"
        ]
        
        Alamofire.request(URL_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                //using swifty json
                guard let data = response.data else { return }
                let json = try! JSON(data:data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let name = json["name"].stringValue
                let email = json["email"].stringValue
                let avatar = json["avatarName"].stringValue
               
                print("----------------------- : > set user data ",id, name)
                UserDataService.instance.setUserData(id: id, avatarColor: color, avatarName: avatar, email: email, name: name)
                print("----------------------- : > create success ")
                completion(true)
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
