//
//  ShareManager.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 19.06.2023.
//
import UIKit
import Photos


struct ShareManager  {
    
    func askPermission(theImage: UIImage) {
        //check and see if we can save photos
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            self.shareToInstagram(theImage)
        }else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
            //   Notifications.showNotification("Please Allow Access To Photos To Share", style: .danger)
        }else if (status == PHAuthorizationStatus.notDetermined) {
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.shareToInstagram(theImage)
                }else {
                    //       Notifications.showNotification("Please Allow Access To Photos To Share", style: .danger)
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
            //   Notifications.showNotification("Please Allow Access To Photos To Share", style: .danger)
        }
    }
    
    func shareToInstagram(_ theImageToShare: UIImage){
        self.saveToCameraRoll(image: theImageToShare) { (theUrl) in
            if let url = theUrl {
                DispatchQueue.main.async {
                    if let path = url.absoluteString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed){
                        let instagram = URL(string: "instagram://library?AssetPath=\(path)")
                        UIApplication.shared.open(instagram!)
                    }
                }
            }
        }
    }
    
    func saveToCameraRoll(image: UIImage, completion: @escaping (URL?) -> Void) {
        var placeHolder: PHObjectPlaceholder? = nil
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            placeHolder = creationRequest.placeholderForCreatedAsset!
        }, completionHandler: { success, error in
            guard success, let placeholder = placeHolder else {
                completion(nil)
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
            guard let asset = assets.firstObject else {
                completion(nil)
                return
            }
            asset.requestContentEditingInput(with: nil, completionHandler: { (editingInput, _) in
                completion(editingInput?.fullSizeImageURL)
            })
        })
    }
    
    func isAppInstalled(_ appName:String) -> Bool{

        let appScheme = "\(appName)://app"
        let appUrl = URL(string: appScheme)

        if UIApplication.shared.canOpenURL(appUrl! as URL){
            return true
        } else {
            return false
        }
    }
    
}
