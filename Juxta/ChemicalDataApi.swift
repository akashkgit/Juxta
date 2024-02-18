//
//  ChemicalDataApi.swift
//  Juxta
//
//  Created by akash kumar on 2/18/24.
//

import Foundation

struct juxtaData:Decodable{
    let item:String
    let effects:[String]
    let signal:[String]
    let usage:[String]
}
struct ChemicalApi{
    let chemicalURL = "https://juxtaserver.akasharchives.com:3000/get/"
    
    func callURL(ingredient: String){
        
        if let url = URL(string: chemicalURL+ingredient){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let resData = data{
                    self.parseJSON(juxta: resData)
                }
            }
            task.resume()
        }
            
    }
    
    func parseJSON(juxta: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(juxtaData.self, from: juxta)
            print("decoded\(decodedData)")
        }catch{
                print(error)
            }
        
    }
  
}
