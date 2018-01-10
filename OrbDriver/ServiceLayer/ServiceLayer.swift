//
//  ServiceLayer.swift
//  TaksyKraft
//
//  Created by Nikhilesh on 29/06/17.
//  Copyright © 2017 TaksyKraft. All rights reserved.
//

import UIKit
public enum ParsingConstant : Int
{
    case Login
}
class ServiceLayer: NSObject {
    let SERVER_ERROR = "Server not responding.\nPlease try after some time."
    let BASE_URL = "http://myryd.com/driver/api/v1/"
    public func loginWithEmailId(mobileNo:String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {

        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)login/mn=\(mobileNo)"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        OrbUserDefaults.setUserMobile(object: mobileNo)
                        successMessage(x)
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
    public func checkLoginWith(mobileNo:String,Otp : String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)checklogin/mn=\(mobileNo)/otp=\(Otp)"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        if let deviceid = obj.parsedDataDict["deviceid"] as? String
                        {
                            if deviceid != ""
                            {
                                let x = message != "" ? message : self.SERVER_ERROR
                                OrbUserDefaults.setDeviceId(object: deviceid)
//                                OrbUserDefaults.setDeviceId(object: "acd9904075f033b7")

                                successMessage(x)
                            }
                            else
                            {
                                let x = message != "" ? message : self.SERVER_ERROR
                                failureMessage(x)
                            }
                        }
                        else
                        {
                            let x = message != "" ? message : self.SERVER_ERROR
                            failureMessage(x)
                        }
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
    func sendActionWithType(actionType : String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        //http://myryd.com/driver/api/v1/action/type=ActionType/id=DeviceID/mobileno=MobileNumber

        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)action/type=\(actionType)/id=\(OrbUserDefaults.getDeviceId())/mobileno=\(OrbUserDefaults.getUserMobile())"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        successMessage(x)
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
    func getProfile(successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        //http://139.59.25.68/driver/api/v1/driver-profile/deviceid=acd9904075f033b7
        
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)driver-profile/deviceid=\(OrbUserDefaults.getDeviceId())"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        if let data = obj.parsedDataDict["data"] as? [String:AnyObject]
                        {
                            let profile = ProfileBO()
                            if let driverDetails = data["driverDetails"] as? [String:AnyObject]
                            {
                                if let fullName = driverDetails["fullName"] as? String
                                {
                                    profile.driverName = fullName
                                }
                                if let PhoneNumber = driverDetails["PhoneNumber"] as? String
                                {
                                    profile.driverPhoneNumber = PhoneNumber
                                }
                                if let languages = driverDetails["languages"] as? String
                                {
                                    profile.driverLanguages = languages
                                }

                            }
                            if let ownerDetails = data["ownerDetails"] as? [String:AnyObject]
                            {
                                if let fullName = ownerDetails["fullName"] as? String
                                {
                                    profile.ownerName = fullName
                                }
                                if let PhoneNumber = ownerDetails["PhoneNumber"] as? String
                                {
                                    profile.ownerPhoneNumber = PhoneNumber
                                }
                                if let languages = ownerDetails["languages"] as? String
                                {
                                    profile.ownerLanguages = languages
                                }
                            }
                            if let cabDetails = data["cabDetails"] as? [String:AnyObject]
                            {
                                if let carNo = cabDetails["carNo"] as? String
                                {
                                    profile.carNo = carNo
                                }
                                if let carType = cabDetails["carType"] as? String
                                {
                                    profile.carType = carType
                                }
                                if let carLocation = cabDetails["carLocation"] as? String
                                {
                                    profile.carLocation = carLocation
                                }
                            }
                            successMessage(profile)

                        }
                        else
                        {
                            let x = message != "" ? message : self.SERVER_ERROR
                            failureMessage(x)

                        }

                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }

    func getCabActivity(successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        //http://myryd.com/driver/api/v1/driver-duration/deviceid=acd9904075f033b7
        
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)driver-duration/deviceid=\(OrbUserDefaults.getDeviceId())"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        if let data = obj.parsedDataDict["data"] as? [String:AnyObject]
                        {
                            let driverActivityBO = DriverActivityBO()
                            if let today = data["today"] as? [String:AnyObject]
                            {
                                if let distance = today["distance"] as? String
                                {
                                    driverActivityBO.todayDistance = distance
                                }
                                if let duration = today["duration"] as? String
                                {
                                    driverActivityBO.todayDuration = duration
                                }
                            }
                            if let thisweek = data["thisweek"] as? [String:AnyObject]
                            {
                                if let distance = thisweek["distance"] as? String
                                {
                                    driverActivityBO.thisWeekDistance = distance
                                }
                                if let duration = thisweek["duration"] as? String
                                {
                                    driverActivityBO.thisWeekDuration = duration
                                }
                            }
                            if let thismonth = data["thismonth"] as? [String:AnyObject]
                            {
                                if let distance = thismonth["distance"] as? String
                                {
                                    driverActivityBO.thisMonthDistance = distance
                                }
                                if let duration = thismonth["duration"] as? String
                                {
                                    driverActivityBO.thismonthDuration = duration
                                }
                            }
                            successMessage(driverActivityBO)
                            
                        }
                        else
                        {
                            let x = message != "" ? message : self.SERVER_ERROR
                            failureMessage(x)
                            
                        }
                        
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
    func getLocations(successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        //http://myryd.com/driver/api/v1/search-list/deviceid=2f1f16f6ad1794c2
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)search-list/deviceid=\(OrbUserDefaults.getDeviceId())"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        var dictLocations = [String:[String]]()
                        if let data = obj.parsedDataDict["data"] as? [String:AnyObject]
                        {
                            if let airport = data["Airports"]  as? [String]
                            {
                                dictLocations["Airports"] = airport
                            }
                            if let airport = data["Areas"]  as? [String]
                            {
                                dictLocations["Areas"] = airport
                            }

                        }
                        successMessage(dictLocations)
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }

    }
    func setTripStatus(isStart : String ,location:String,isAirport:String,isPool:String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        //http://myryd.com/driver/api/trip/deviceid={deviceid}/pool={pool}/airport={airport}/location={location}/type={type}
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.Login.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "\(BASE_URL)trip/deviceid=\(OrbUserDefaults.getDeviceId())/pool=\(isPool)/airport=\(isAirport)/location=\(location)/type=\(isStart)"
        obj.params = [:]
        obj.doGetSOAPResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let error = obj.parsedDataDict["error"] as? String,let message = obj.parsedDataDict["message"] as? String
                {
                    if error == "true"
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        failureMessage(x)
                    }
                    else
                    {
                        let x = message != "" ? message : self.SERVER_ERROR
                        successMessage(x)
                    }
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
//MARK:- Utility Methods
    public func convertDictionaryToString(dict: [String:String]) -> String? {
        var strReturn = ""
        for (key,val) in dict
        {
            strReturn = strReturn.appending("\(key)=\(val)&")
        }
        strReturn = String(strReturn.dropLast())
        
        return strReturn
    }
    
    
    
    public func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    public func encodeSpecialCharactersManually(_ strParam : String)-> String
    {
        
        var strParams = strParam.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
        strParams = strParams!.replacingOccurrences(of: "&", with:"%26")
        return strParams!
    }
    
    public func convertSpecialCharactersFromStringForAddress(_ strParam : String)-> String
    {
        
        var strParams = strParam.replacingOccurrences(of: "&", with:"&amp;")
        strParams = strParams.replacingOccurrences(of: ">", with: "&gt;")
        strParams = strParams.replacingOccurrences(of: "<", with: "&lt;")
        strParams = strParams.replacingOccurrences(of: "\"", with: "&quot;")
        strParams = strParams.replacingOccurrences(of: "'", with: "&apos;")
        return strParams
    }
    public func convertStringFromSpecialCharacters(strParam : String)-> String
    {
        
        var strParams = strParam.replacingOccurrences(of:"%26", with:"&")
        strParams = strParams.replacingOccurrences(of:"&amp;", with:"&")
        strParams = strParams.replacingOccurrences(of:"%3E", with: ">")
        strParams = strParams.replacingOccurrences(of:"%3C" , with: "<")
        strParams = strParams.replacingOccurrences(of:"&quot;", with: "\"")
        strParams = strParams.replacingOccurrences(of:"&apos;" , with: "'")
        
        return strParams
    }

}
