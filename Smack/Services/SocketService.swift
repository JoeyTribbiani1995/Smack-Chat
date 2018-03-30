//
//  SocketService.swift
//  Smack
//
//  Created by Dũng Võ on 3/30/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string : BASE_URL)!)
    var socket : SocketIOClient!

    
    func establishConnection(){
        socket = SocketService.instance.manager.defaultSocket
        
        socket.connect()
       
    }

    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName : String , channelDescription : String , completion : @escaping CompletionHandler){
        let socket = SocketService.instance.manager.defaultSocket
        socket.emit("newChannel", channelDescription,channelName)
        print("new channel ------------------")
        completion(true)
    }
    
    func getChannel(completion : @escaping CompletionHandler){
       socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
        
            let newChannel = Channel(channelName: channelName, channelDescription: channelDescription, id: channelId)
        
            MessageService.instance.channels.append(newChannel)
        
            print("get channel --------")
            completion(true)
        }
    }
    
}
