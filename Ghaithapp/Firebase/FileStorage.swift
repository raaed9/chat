//
//  FileStorage.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 19/10/1443 AH.
//

import Foundation
import UIKit
import ProgressHUD
import FirebaseStorage
//import Gallery


let storage = Storage.storage()

class FileStorage {
    
    //MARK: - Images
    
    class func uploadImage(_ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?)-> Void) {
        //1. Create folder on firestore
        let storageRef = storage.reference(forURL: KFILEREFERENCE).child(directory)
        
        
        //2. Convert the image to data
        let imageData = image.jpegData(compressionQuality: 0.5)
        
        //3. put the data into firestore and return the link
        var task : StorageUploadTask!
        
        task = storageRef.putData(imageData!, metadata: nil, completion: { metaData, error in
            
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            if error != nil {
                print("Error uploading image \(error!.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion (nil)
                    return
                }
                
                completion(downloadUrl.absoluteString)
            }
            
            
            
        })
        //4. Observe percentage uplaod
        
        task.observe(StorageTaskStatus.progress) { snapshot in
            
            let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    class func downloadImage(imageUrl: String, completion: @escaping(_ Image: UIImage?)->Void) {

        let imageFileName = fileNameFrom(fileUrl: imageUrl)
        
        if fileExistsAtpath(path: imageFileName) {
            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(fileName: imageFileName)) {
                completion (contentsOfFile)
            } else {
                print("could not convert local image")
                completion(UIImage(named: "avatar")!)
            }
        } else {
            if imageUrl != "" {
                
                let documentUrl = URL(string: imageUrl)
                let downloadQueue = DispatchQueue (label: "imageDownloadQueue")
                
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    if data != nil {
                        FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)
                        DispatchQueue.main.async {
                            completion(UIImage(data: data! as Data))
                        }
                    } else {
                        print("no document found in database")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    //MARK: - Upload Video
    
    
    class func uploadVideo(_ video: NSData, directory: String, completion: @escaping (_ videoLink: String?)-> Void) {
        //1. Create folder on firestore
        let storageRef = storage.reference(forURL: KFILEREFERENCE).child(directory)
        
        
        //3. put the data into firestore and return the link
        var task : StorageUploadTask!
        
        task = storageRef.putData(video as Data, metadata: nil, completion: { metaData, error in
            
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            if error != nil {
                print("Error uploading image \(error!.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                
                guard let downloadUrl = url else {
                    completion (nil)
                    return
                }
                
                completion(downloadUrl.absoluteString)
            }
            
            
            
        })
        //4. Observe percentage uplaod
        
        task.observe(StorageTaskStatus.progress) { snapshot in
            
            let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }
    
    
    class func downloadVideo(videoUrl: String, completion: @escaping(_ isReadyToPlay: Bool, _ videoFileName: String)->Void) {

        let videoFileName = fileNameFrom(fileUrl: videoUrl) + ".mov"
        
        if fileExistsAtpath(path: videoFileName) {

                completion (true ,videoFileName)

        } else {
            if videoUrl != "" {
                
                let documentUrl = URL(string: videoUrl)
                let downloadQueue = DispatchQueue (label: "videoDownloadQueue")
                
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    if data != nil {
                        FileStorage.saveFileLocally(fileData: data!, fileName: videoFileName)
                        DispatchQueue.main.async {
                            completion(true, videoFileName)
                        }
                    } else {
                        print("no document found in database")
                    }
                }
            }
        }
    }
    
    //MARK: - Audio
    
    class func uploadAudio(_ audioFileName: String, directory: String, completion: @escaping (_ audioLink: String?)-> Void) {
        
        //1. Create folder on firestore
        
        let fileName = audioFileName + ".m4a"
        let storageRef = storage.reference(forURL: KFILEREFERENCE).child(directory)
        
        
        //3. put the data into firestore and return the link
        var task : StorageUploadTask!
        
        if fileExistsAtpath(path: fileName) {
        
            if let audioData = NSData(contentsOfFile: fileInDocumentsDirectory(fileName: fileName)) {
                
                
                task = storageRef.putData(audioData as Data, metadata: nil, completion: { metaData, error in
                    
                    task.removeAllObservers()
                    ProgressHUD.dismiss()
                    
                    if error != nil {
                        print("Error uploading audio \(error!.localizedDescription)")
                        return
                    }
                    
                    storageRef.downloadURL { (url, error) in
                        
                        guard let downloadUrl = url else {
                            completion (nil)
                            return
                        }
                        
                        completion(downloadUrl.absoluteString)
                    }
                    
                    
                    
                })
                //4. Observe percentage uplaod
                
                task.observe(StorageTaskStatus.progress) { snapshot in
                    
                    let progress = snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
                    
                    ProgressHUD.showProgress(CGFloat(progress))
                }
                
            }
                
        } else {
            print("Noting to upload, or file does not exist")
        }
    }
    
    
    class func downloadAudio(audioUrl: String, completion: @escaping(_ audioFileName: String)->Void) {

        let audioFileName = fileNameFrom(fileUrl: audioUrl) + ".m4a"
        
        if fileExistsAtpath(path: audioFileName) {

                completion (audioFileName)

        } else {
            if audioUrl != "" {
                
                let documentUrl = URL(string: audioUrl)
                let downloadQueue = DispatchQueue (label: "audioDownloadQueue")
                
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    if data != nil {
                        FileStorage.saveFileLocally(fileData: data!, fileName: audioFileName)
                        DispatchQueue.main.async {
                            completion(audioFileName)
                        }
                    } else {
                        print("no document found in database")
                    }
                }
            }
        }
    }
    
    
        //MARK: - Save file locally
    class func saveFileLocally (fileData: NSData, fileName: String) {
        
        let docUrl = getDocumentURL().appendingPathComponent(fileName, isDirectory: false)
        
        fileData.write(to: docUrl, atomically: true)
    }
    
    
}

// Helpers

func getDocumentURL() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    
}

func fileInDocumentsDirectory(fileName: String) -> String {
    return getDocumentURL().appendingPathComponent(fileName).path
}

func fileExistsAtpath(path: String) -> Bool {
    return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(fileName: path))
}
