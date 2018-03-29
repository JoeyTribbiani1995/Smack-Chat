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
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
}
