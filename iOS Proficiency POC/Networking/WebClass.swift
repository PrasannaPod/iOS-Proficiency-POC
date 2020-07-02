//
//  WebClass.swift
//  iOS Proficiency POC
//
//  Created by prasu on 01/07/20.
//  Copyright © 2020 prasanna. All rights reserved.
//

import UIKit
import Foundation

protocol webclassdelegate: class {
    func getResponse(result: NSDictionary)
    func getErrorResponse(error: NSString)
}

class WebClass: NSObject {
    
    private var reachability = try! Reachability()
    weak var webdelegate: webclassdelegate?
    
    func observeReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        } catch let error {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            print("Network available via Cellular Data.")
        case .wifi:
            print("Network available via WiFi.")
        case .none:
            print("Network is not available.")
        case .unavailable:
            print("Network is  unavailable.")
        }
      }
    
      func requestWithURL(requestUrl: String) {
        let urlwithPercentEscapes = requestUrl.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
         let serviceUrl = URL(string: urlwithPercentEscapes)

         var request = URLRequest(url: serviceUrl!)

         request.httpMethod = "GET"
         request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, _, error) in
             // Get the dat from API and pass through deledate methods
            guard let data = data else { return }
            do {
                let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                      print("could not convert data to UTF-8 format")
                      return
                 }
                do {
                   if let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format) as? NSDictionary {
                    print(responseJSONDict)
                        self.mainResponse(result: responseJSONDict)
                        }
                } catch {
                    print("Err", error)
                    let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    self.eroorResponse(result: jsonStr ?? "")
                }
             }
         }
         task.resume()
         session.finishTasksAndInvalidate()
        
    }
    func mainResponse(result: NSDictionary) {
        self.webdelegate?.getResponse(result: result)
    }

    func eroorResponse(result: NSString) {
        self.webdelegate?.getErrorResponse(error: result)
    }
}
