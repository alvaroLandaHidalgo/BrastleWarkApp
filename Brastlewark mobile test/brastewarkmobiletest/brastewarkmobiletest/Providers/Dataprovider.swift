//
//  Dataprovider.swift
//  brastewarkmobiletest
//
//  Created by alvaro Landa Hidalgo on 29/6/21.
//

import Foundation
import Alamofire

public class DataProvider {
    
    static func getInhabitant(completion: @escaping ([Inhabitant])-> Void){
        let url =  "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
        Alamofire.request(url, method: .get).responseJSON { response in
//            print("result: \(response)")
            
            if let json = response.result.value{
                var totalInhabitants = [Inhabitant]()
                
                if let object = json as? NSDictionary{
                    if let brastewarkArray = object["Brastlewark"] as! [Any]?{
                        for inhabitants in brastewarkArray {
                            let inhabitant : [String: Any] = inhabitants as! [String: Any]
                            let age = inhabitant["age"] as! Int
                            let hairColor = inhabitant["hair_color"] as! String
                            let height = inhabitant["height"] as! Double
                            let id = inhabitant["id"] as! Int
                            let name = inhabitant["name"] as! String
                            let thumbnail = inhabitant["thumbnail"] as! String
                            let weight = inhabitant["weight"] as! Double
                            let friendsDict = inhabitant["friends"] as! [Any]
                            var friendsArray = [String]()
                            for friends in friendsDict{
                                
                                let friend = friends as! String
                                friendsArray.append(friend)
                            }
                            let professionsDict = inhabitant["professions"] as! [Any]
                            var professionsArray = [String]()
                            for professions in professionsDict{
                                let profession = professions as! String
                                professionsArray.append(profession)
                            }
                            
                            totalInhabitants.append(Inhabitant(id: id, name: name, thumbnail: thumbnail, age: age, weight: weight, height: height, hairColor: hairColor, professions: professionsArray, friends: friendsArray))
                            
                        }
                        OperationQueue.main.addOperation {
                            completion(totalInhabitants)
                            debugPrint("Operation Success")
                    }
                    }else{
                    OperationQueue.main.addOperation {
                        completion(totalInhabitants)
                        debugPrint("0 Inhabitants")
                    }
                }
                }else{
                print("BAD JSON")
                OperationQueue.main.addOperation {
                    completion(totalInhabitants)
                    }
                }
            }
        }
    }
}
