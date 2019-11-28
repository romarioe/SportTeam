//
//  NetworkNewsFetcher.swift
//  AnimateTest
//
//  Created by Roman Efimov on 29/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import Foundation
import UIKit

class NetworkNewsFetcher {
    
    let networkService = NetworkService()
    
    var news: [News] = []
    
    func fetchNews(completion: @escaping ([News]?) -> Void){
        
        networkService.fetchNews { (result) in
            
            switch result {
            case .success(let data):
                do {
                    
                    let rootDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
                    
                    let response = rootDictionary!["response"] as! Dictionary<String, Any>
                    
                    let items = response["items"] as! [Dictionary<String, Any>]
                    
                    var returnStruct = News(text: "", date: 0, width: [], height: [], photosURL: [], videosTrackCode: [])
                    var photosArray: [String?] = []
                    var videosArray: [String] = []
                    var widthsArray: [Int] = []
                    var heightsArray: [Int] = []
                    
                    
                    for item in items {
                        photosArray.removeAll()
                        videosArray.removeAll()
                        widthsArray.removeAll()
                        heightsArray.removeAll()
                        
                        returnStruct.text = item["text"] as! String
                        returnStruct.date = item["date"] as! Int
                        var attCount = 0
                        if let attachments = item["attachments"] as? [Dictionary<String, Any>] {
                   
                            for attachment in attachments {
                                attCount += 1
                                if attachment["type"] as! String == "photo" {
                                    
                                    let photo = attachment["photo"] as! Dictionary<String, Any>
                                    widthsArray.append(photo["width"] as! Int)
                                    heightsArray.append(photo["height"] as! Int)
                                    photosArray.append(photo["photo_604"] as? String)
                                }
                                else
                                    if attachment["type"] as! String == "video"{
                                        let video = attachment["video"] as! Dictionary<String, Any>
                                        widthsArray.append(video["width"] as! Int)
                                        heightsArray.append(video["height"] as! Int)
                                        photosArray.append(video["photo_800"] as? String)
                                        videosArray.append(video["track_code"] as! String)
                                }
                                if attachment["type"] as! String == "album" {
                                     let album = attachment["album"] as! Dictionary<String, Any>
                                     let thumb = album["thumb"] as! Dictionary<String, Any>
                                    widthsArray.append(thumb["width"] as! Int)
                                    heightsArray.append(thumb["height"] as! Int)
                                    photosArray.append(thumb["photo_604"] as? String)
                                }
                            }
                            
                        }
                       
                            
                      
                        
                        if let copyHistories = item["copy_history"] as? [Dictionary<String, Any>] {
                                    
                            for copyHistory in copyHistories {
                                
                                if let copyHistoryText = copyHistory["text"] as? String {
                                    returnStruct.text = copyHistoryText
                                }
                                
                               let attachments = copyHistory["attachments"] as! [Dictionary<String, Any>]
                                    
                                    for attachment in attachments {
                                        attCount += 1
                                        if attachment["type"] as! String == "photo" {
                                            
                                            let photo = attachment["photo"] as! Dictionary<String, Any>
                                            widthsArray.append(photo["width"] as! Int)
                                            heightsArray.append(photo["height"] as! Int)
                                            photosArray.append(photo["photo_604"] as? String)
                                        }
                                        else
                                            if attachment["type"] as! String == "video"{
                                                let video = attachment["video"] as! Dictionary<String, Any>
                                                widthsArray.append(video["width"] as! Int)
                                                heightsArray.append(video["height"] as! Int)
                                                photosArray.append(video["photo_800"] as? String)
                                                videosArray.append(video["track_code"] as! String)
                                        }
                                        
                                        if attachment["type"] as! String == "album" {
                                             let album = attachment["album"] as! Dictionary<String, Any>
                                             let thumb = album["thumb"] as! Dictionary<String, Any>
                                            widthsArray.append(thumb["width"] as! Int)
                                            heightsArray.append(thumb["height"] as! Int)
                                            photosArray.append(thumb["photo_604"] as? String)
                                        }
                                    }
                                

               
                            }

                        }
                        
                        if attCount == 0 { //Проверка на количество картинок в посте. Если их нет, то вместо ссылки сохраняем nil
                            photosArray.append(nil)
                        }
                        
                        returnStruct.width = widthsArray
                        returnStruct.height = heightsArray
                        returnStruct.photosURL = photosArray
                        returnStruct.videosTrackCode = videosArray
                        
                        self.news.append(returnStruct)
                        
                    }
                    
                    completion(self.news)
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil)
                    
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
                
            }
            
            
            
        }
    }
    
    
    
}


