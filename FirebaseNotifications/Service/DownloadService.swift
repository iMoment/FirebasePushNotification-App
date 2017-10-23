//
//  DownloadService.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 23/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import Foundation

class DownloadService {
    
    private init() {}
    static let sharedInstance = DownloadService()
    
    func getImage(with urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            let fileManager = FileManager.default
            
            guard let data = data,
                let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            
            //  MARK: Create url file that we will be writing
            let fileUrl = documentsUrl.appendingPathComponent("image.jpg")
            //  MARK: Try to write data
            do {
                try data.write(to: fileUrl)
                //  MARK: Come back to main thread
                DispatchQueue.main.async {
                    completion(fileUrl)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
