//
//  UserDataService.swift
//  Smack
//
//  Created by Dũng Võ on 3/27/18.
//  Copyright © 2018 Dũng Võ. All rights reserved.
//

import Foundation
class UserDataService {
    static let instance = UserDataService()
    
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id : String , avatarColor : String , avatarName : String , email : String , name : String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName : String){
        self.avatarName = avatarName
    }
    
    func returnColor(components : String ) -> UIColor {
        
        let scanner = Scanner(string : components)
        let skipped = CharacterSet(charactersIn: "[],")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r  else {return defaultColor}
        guard let gUnwrapped = g  else {return defaultColor}
        guard let bUnwrapped = b  else {return defaultColor}
        guard let aUnwrapped = a  else {return defaultColor}
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        return UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
    }
    
    func logoutUser(){
        id = ""
        avatarColor = ""
        name = ""
        email = ""
        avatarName = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}
