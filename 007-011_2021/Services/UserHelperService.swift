//
//  UserHelperService.swift
//  007-011_2021
//
//  Created by Семен Соколов on 28.11.2021.
//

import Foundation

class UserHelperService {
    
    //MARK: - Dependencies
    static let shared = UserHelperService()
    
    //MARK: - Functions to set new user
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
}
