//
//  UserRequest.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import Foundation

import Foundation

public struct UserActivitiesRequest {
   
    
    func getURL() ->URL {
        
        return URL(string: WebServiceURL.userActivities)!
    }
    
    func getParams(enquries: Enqries?) -> [String: Any]?{
        if let userRecord = enquries {
            
            return ["email" : userRecord.email,
                    "isSubscription": userRecord.subscription,
                    "visaType" : userRecord.visaTypes,
                    "userDesc" : userRecord.description]
        }
        return nil
    }
    
    
}
