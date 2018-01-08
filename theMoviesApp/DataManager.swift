//
//  DataManager.swift
//  theMoviesApp
//
//  Created by Sanjay Mali on 09/01/18.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//

import Foundation
public final class DataManager {
    public static func getMoviesJSON(completion:@escaping (_ data:Data?, _ error:Error?) -> Void){
        DispatchQueue.global(qos: .background).async {
            
            let apiUrl = "https://api.themoviedb.org/4/list/1?api_key=b4ee6d2b12cb6216dad6784010f6af7f&page=1"
            guard let url = URL(string:apiUrl) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy  = .useProtocolCachePolicy
            request.timeoutInterval = 10.0
            
            let headers = [
                "content-type": "application/json;charset=utf-8",
                "authorization": "Bearer <<access_token>>"
            ]
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.allHTTPHeaderFields = headers
            
            do {
                let jsonBody = try JSONEncoder().encode("")
                request.httpBody = jsonBody
            } catch {
                print("--------")
            }
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                do{
                    if let er  = error  {
                        print("error = \(er.localizedDescription)")
//                        KRProgressHUD.dismiss()
                    }
                    
                    guard let mdata = data else {
                        return
                    }
                    completion(data,nil)
                }
                catch{
                    print(error)
                }
                }.resume()
            
            
        }
    }

}
