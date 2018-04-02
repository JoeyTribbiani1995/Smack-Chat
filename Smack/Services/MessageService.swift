//
//  MessageService.swift
//  Smack
//
//  Created by Dũng Võ on 3/29/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    var unreadChannels = [String]()
    
    func findAllChannel(completion : @escaping CompletionHandler) {
        
        Alamofire.request(URL_FIND_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = try! JSON(data: data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let channelName = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        
                        let tempChannel = Channel(channelName: channelName, channelDescription: channelDescription, id: id)
                        
                        self.channels.append(tempChannel)
                    }
                }
                
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
    
    func getAllMessageByChannel(channelId: String , completion : @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                
                guard let data = response.data else { return }
                if let json = try! JSON(data : data).array{
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let messageTemp = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id:id, timeStamp: timeStamp)
                        self.messages.append(messageTemp)
                        
                    }
                }
                completion(true)
                
            }else {
                debugPrint(response.result.error as Any)
                completion(true)
            }
        }
    }
    func clearMessages(){
        messages.removeAll()
    }
    
    
    
    
}
