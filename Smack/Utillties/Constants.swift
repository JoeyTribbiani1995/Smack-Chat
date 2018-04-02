//
//  Constants.swift
//  Smack
//
//  Created by Dũng Võ on 3/26/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success : Bool) -> ()



//seques

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let TO_AVATAR_PICKER = "toCreateAccount"


//user defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//url

let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_FIND_CHANNEL = "\(BASE_URL)channel/"
let URL_GET_MESAGES = "\(BASE_URL)message/byChannel/"

//headers
let HEADER = [
    "Content-Type" : "application/json;charset-utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type" :"application/json"
]

//colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.4352941176, green: 0.6902027726, blue: 0.8282268047, alpha: 0.5)

//notification constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notiUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsloaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelselected")


